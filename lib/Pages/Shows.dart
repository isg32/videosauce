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
      debugShowCheckedModeBanner: false,
      home: const Shows(),
    );
  }
}

class Shows extends StatefulWidget {
  const Shows({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Shows> {
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
    final response = await http.get(Uri.parse('https://vidsrc.xyz/tvshows/latest/page-1.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        shows = List<Map<String, dynamic>>.from(data["result"]);
        print(
          shows
        );
        filteredShows = List<Map<String, dynamic>>.from(data["result"]);
      });
    } else {
      throw Exception('Failed to load shows');
    }
  
  }
  

  Future<void> searchShows(String query) async {
    final response = await http.get(Uri.parse('https://vidsrc.xyz/movies/latest/page-1.json'));

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Center(child: const Text("Latest shows", style: TextStyle(color: Colors.white, fontSize: 30) ,)),
        backgroundColor: Colors.black,
        actions: const [
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredShows.length,
          itemBuilder: (context, index) {
            final show = filteredShows[index];
            print(filteredShows);
            return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                          child: ListTile(
                            trailing: InkWell(
                              onTap: () {
                                _showPopup(context,  show['tmdb_id']);
                              },
                              child: const Icon(Icons.arrow_forward_ios)
                            ),
                           title:Text(
                              show['title'],
                              style: const TextStyle(fontSize: 19.0),
                            ),   
                            subtitle: Text('ID: '+show['tmdb_id']),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network('https://www.shutterstock.com/image-vector/film-clapper-3d-cartoon-icon-600nw-2239181291.jpg'),),     
                                        ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, var movieId) async {
      String url = 'https://vidsrc.xyz/embed/show?tmdb=$movieId';

  if (true) {
    await launch(url);
  } 

Future<bool> checkUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

}