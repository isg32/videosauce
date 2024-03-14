import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

const String apiKey = '1abb3e68d878be1155d781ce812f80a8'; // Replace with your TMDB API key

class SearchM extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<SearchM> {
  TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];

  void _searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body)['results'];
        print(_searchResults);
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: TextField(
          controller: _controller,
          style: TextStyle(color: Colors.white), // Text color
          decoration: InputDecoration(
            hintText: 'Search Movies...',
            hintStyle: TextStyle(color: Colors.white), // Hint text color
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white, // Icon color
              onPressed: () {
                _searchMovies(_controller.text);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: _searchResults[index]['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${_searchResults[index]['poster_path']}'
                          )
                        : Icon(Icons.movie),
                    title: Text(
                      _searchResults[index]['title'],
                      style: TextStyle(color: Colors.black, fontSize: 20), // Text color
                    ),
                    subtitle: Text(
                      _searchResults[index]['overview'],
                      style: TextStyle(color: Colors.black), // Text color
                    ),
                    trailing: InkWell(
                                onTap: () {
                                  _showPopup(context,  _searchResults[index]['id']);
                                },
                                child: const Icon(Icons.arrow_forward_ios)
                              ),
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

void _showPopup(BuildContext context, var movieId) async {
      String url = 'https://vidsrc.xyz/embed/movie?tmdb=$movieId';

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