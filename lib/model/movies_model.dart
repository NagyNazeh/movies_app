import 'dart:convert';

import 'package:http/http.dart' as http;

class Movies {
  List<Results> results;
  int page;
  int totalResults;
  Dates dates;
  int totalPages;

  Movies({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    page = json['page'];
    totalResults = json['total_results'];
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Results {
  dynamic popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  dynamic voteAverage;
  String overview;
  String releaseDate;

  Results(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}

class Dates {
  String maximum;
  String minimum;

  Dates({this.maximum, this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maximum'] = this.maximum;
    data['minimum'] = this.minimum;
    return data;
  }
}

String _upComingMovies =
    'https://api.themoviedb.org/3/movie/upcoming?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US&page=1';

Future<Movies> getUpComingMovies() async {
  http.Response futurePost = await http.get(_upComingMovies);
  if (futurePost.statusCode == 200) {
    return Movies.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}

String _topRatedMovies =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US&page=1';

Future<Movies> getTopRatedMovies() async {
  http.Response futurePost = await http.get(_topRatedMovies);
  if (futurePost.statusCode == 200) {
    return Movies.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}

String _popularMovies =
    'https://api.themoviedb.org/3/movie/popular?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US&page=1';

Future<Movies> getPopularMovies() async {
  http.Response futurePost = await http.get(_popularMovies);
  if (futurePost.statusCode == 200) {
    return Movies.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}
