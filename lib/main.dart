import 'package:flutter/material.dart';
import 'package:movie/data/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie/pages/movielist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  var movies;
  
  static final apiKey = "400d1db0ec96a230ff11515ef71fc9e1";
  String url = "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey";

  @override
  void initState() {
    Storage().getDarkTheme().then((value) {
      if (value != null) {
        setState(() {
          isDark = value;
        });
      }
    });

    // Fetch the movies
    fetchMovies();

    super.initState();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: isDark ? Brightness.dark : Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: Text("MovieApp"),
          actions: <Widget>[
            Switch(
              value: isDark,
              onChanged: (value) async {
                await Storage().setDarkTheme(value);
                setState(() {
                  isDark = value;
                });
              },
            )
          ],
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
                    return MovieList(
                      movie: movies[i],
                    );
                  },
                ),
              ),
      ),
    );
  }

  Future<void> _refreshController() async {
    setState(() {
      movies = null;
    });

    fetchMovies();
  }
}
