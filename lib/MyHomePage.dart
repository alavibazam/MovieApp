import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:MovieApp/MovieItem.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage(this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final apiKey = "YourAPIKey";
  String url = "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey";

  var movies;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async {
    var response = await http.get(url);
    var data = json.decode(response.body);

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: movies == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshController,
              child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, i) {
                return MovieItem(
                  movie: movies[i],
                );
              },
            )),
    );
  }

  Future<Null> _refreshController() async {
    movies = null;
    fetchMovies();
  }
}
