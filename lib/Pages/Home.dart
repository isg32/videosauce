import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Homeapp extends StatelessWidget {
  const Homeapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb Shows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  final String apiKey = '1abb3e68d878be1155d781ce812f80a8'; // Replace with your TMDb API key
  final String baseUrl = 'https://api.themoviedb.org/3';

  List<Map<String, dynamic>> shows = [];
  List<Map<String, dynamic>> filteredShows = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        shows = List<Map<String, dynamic>>.from(data['results']);
        filteredShows = List<Map<String, dynamic>>.from(data['results']);
      });
    } else {
      throw Exception('Failed to load shows');
    }
  }

  Future<void> searchShows(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        filteredShows = List<Map<String, dynamic>>.from(data['results']);
      });
    } else {
      throw Exception('Failed to search shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("isg32's Shows"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch(
                context: context,
                delegate: ShowSearch(apiKey),
              );

              if (query != null) {
                searchShows(query);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // You can adjust the number of columns as needed
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: filteredShows.length,
          itemBuilder: (context, index) {
            final show = filteredShows[index];
            print(filteredShows);
            final posterPath = show['poster_path'];
            final posterUrl = 'https://image.tmdb.org/t/p/w200$posterPath';

            return Card(
              child: InkWell(
                onTap: () {
                  _showPopup(context,  show['id'], show['media_type']);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: posterPath != null
                              ? Image.network(posterUrl, fit: BoxFit.cover)
                              : const Placeholder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          show['name'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, int movieId, String mediaType) async {
  final url = mediaType == 'movie'
      ? 'https://vidsrc.xyz/embed/movie?tmdb=$movieId'
      : 'https://vidsrc.xyz/embed/tv?tmdb=$movieId';

  final bool urlWorked = await _checkUrl(url);

  if (urlWorked) {
    await launch(url);
  } else {
    // Handle the case when both URLs fail
    // You can show an error message or take appropriate action
    print('Failed to load the video');
  }
}

Future<bool> _checkUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

class ShowSearch extends SearchDelegate<String> {
  final String apiKey;

  ShowSearch(this.apiKey);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // The results are displayed in real-time as the user types
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions are not needed as the results are displayed in real-time
    return Container();
  }

  @override
  Future<void> showResults(BuildContext context) async {
    // The results are displayed in real-time as the user types
    close(context, query);
  }
}
