import 'package:flutter/foundation.dart';
import 'package:cinestream/model/movie_model.dart';
import 'package:cinestream/severices/api_getting.dart';

class ApiProvider with ChangeNotifier {
  MovieModel? trendingmovies;
  MovieModel? topshow;
  MovieModel? upcomming;
  MovieModel? recomended;
  MovieModel? popular;
  MovieModel? searchlist;
  bool isLoading = true;

  ApiProvider() {
    // Fetch trending movies when the provider is initialized
    getTrendingList();
  }

  Future<void> getTrendingList() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      trendingmovies = await ApiService().getTrending();
      print("Trending Movies: ${trendingmovies?.results}");
    } catch (error) {
      print("Error fetching trending movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTopShow() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      topshow = await ApiService().TopShow();
      print("Top Show: ${topshow?.results}");
    } catch (error) {
      print("Error fetching trending movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUpcomming() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      upcomming = await ApiService().Upcoming();
      print("Top Show: ${upcomming?.results}");
    } catch (error) {
      print("Error fetching trending movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> Recomended(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      recomended = await ApiService().getrecommended(id);
      print("Top Show: ${recomended?.results}");
    } catch (error) {
      print("Error fetching Recomended movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> Popularmovies() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      popular = await ApiService().Popular();
      print("Top Show: ${popular?.results}");
    } catch (error) {
      print("Error fetching Recomended movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> SearchMovie(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch trending movies from the API
      searchlist = await ApiService().Search(query);
      print("Top Show: ${searchlist?.results}");
    } catch (error) {
      print("Error fetching Recomended movies: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
