import 'package:flutter/material.dart';
import 'package:MovieApp/MovieItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App 2.0',
      theme: ThemeData(
        brightness: isDark
                    ? Brightness.dark
                    : Brightness.light
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Movie App"),
          centerTitle: true,
          actions: <Widget>[
            Switch(
              value: isDark,
              onChanged: (value) {
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
                    return MovieItem(
                      movie: movies[i],
                    );
                  },
                )),
      ),
    );
  }

  Future<Null> _refreshController() async {
    movies = null;
    fetchMovies();
  }
}
