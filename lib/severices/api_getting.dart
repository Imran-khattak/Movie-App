import 'dart:convert';

import 'package:cinestream/model/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<MovieModel> getTrending() async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      //   print('Success');
      var json = jsonDecode(response.body);

      // print("Raw JSON Response: ${response.body}"); // Raw JSON response
      // print("Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        //  print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load trending movies');
  }

  Future<MovieModel> TopShow() async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      print('top show Success');
      var json = jsonDecode(response.body);

      // print(
      //     "Top show Raw JSON Response: ${response.body}"); // Raw JSON response
      // print("Top Show Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load trending movies');
  }

  Future<MovieModel> Popular() async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/popular?api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      print('Popular show Success');
      var json = jsonDecode(response.body);

      // print(
      //     "Top show Raw JSON Response: ${response.body}"); // Raw JSON response
      // print("Top Show Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load trending movies');
  }

  Future<MovieModel> Search(String query) async {
    final endpoint =
        "https://api.themoviedb.org/3/search/movie?query=$query&api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZGU0ZmJkNDBhNTIxNjY1MWNmOTU0MjExMmYxNTNmMCIsIm5iZiI6MTcyMjA1NjAyNy43MjE1NjUsInN1YiI6IjY2OWRmOGM1NTdkNTg5NTk5MzM3ZmZkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MKhFNqZG66as5galrhMqU-YEAa2a7cuxwK2m5IDBxK8'
    });

    if (response.statusCode == 200) {
      print('Search query Success');
      var json = jsonDecode(response.body);

      // print(
      //     "Top show Raw JSON Response: ${response.body}"); // Raw JSON response
      // print("Top Show Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load sarch movies');
  }

  Future<MovieModel> Upcoming() async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      print('upcomming show Success');
      var json = jsonDecode(response.body);

      // print(
      //     "upcomming show Raw JSON Response: ${response.body}"); // Raw JSON response
      // print("upcomming Show Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        //  print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load trending movies');
  }

  Future<MovieModel> getrecommended(int movieId) async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/${movieId}/recommendations?api_key=bde4fbd40a5216651cf9542112f153f0";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      print('Recomended Success');
      var json = jsonDecode(response.body);

      //  print(
      //      "Raw JSON of Recomended Response: ${response.body}"); // Raw JSON response
      //  print(" Recomended Decoded JSON: $json"); // Decoded JSON object

      try {
        MovieModel list = MovieModel.fromJson(json);
        //  print("list : $list"); // List from JSON
        return list;
      } catch (e) {
        print("Error parsing Models: $e");
        rethrow; // Optionally rethrow if needed
      }
    }
    throw Exception('Failed to load Recomended movies');
  }
}
