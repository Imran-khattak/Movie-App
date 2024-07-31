import 'package:cinestream/utils/geners.dart';

class MovieModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  MovieModel({this.page, this.results, this.totalPages, this.totalResults});

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  String? backdropPath;
  int? id;
  String? name;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;
  String? title;
  String? originalTitle;
  String? releaseDate;
  bool? video;

  Results({
    this.backdropPath,
    this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.video,
  });

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    adult = json['adult'];
    originalLanguage = json['original_language'];
    genreIds =
        json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null;
    popularity = json['popularity']?.toDouble();
    firstAirDate = json['first_air_date'];
    voteAverage = json['vote_average']?.toDouble();
    voteCount = json['vote_count'];
    originCountry = json['origin_country'] != null
        ? List<String>.from(json['origin_country'])
        : null;
    title = json['title'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['name'] = name;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['adult'] = adult;
    data['original_language'] = originalLanguage;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['first_air_date'] = firstAirDate;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['origin_country'] = originCountry;
    data['title'] = title;
    data['original_title'] = originalTitle;
    data['release_date'] = releaseDate;
    data['video'] = video;
    return data;
  }

  /// Method to get genre names as a string
  String getGenresAsString() {
    if (genreIds == null) {
      return 'Unknown';
    }

    List<String> genreNames = genreIds!.map((id) {
      final genre = Genre.genreList.firstWhere((g) => g.id == id,
          orElse: () => Genre(id: id, name: 'Unknown'));
      return genre.name;
    }).toList();

    return genreNames.join(', ');
  }
}
