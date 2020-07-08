import 'dart:convert';

import 'package:http/http.dart' as http;

class RecommendationsSeries {
  int page;
  List<Results> results;
  int totalPages;
  int totalResults;

  RecommendationsSeries(
      {this.page, this.results, this.totalPages, this.totalResults});

  RecommendationsSeries.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Results {
  String backdropPath;
  String firstAirDate;
  List<int> genreIds;
  int id;
  String title;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  String posterPath;
  double voteAverage;
  int voteCount;
  List<Networks> networks;
  double popularity;

  Results(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.title,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.posterPath,
      this.voteAverage,
      this.voteCount,
      this.networks,
      this.popularity});

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    title = json['name'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    if (json['networks'] != null) {
      networks = new List<Networks>();
      json['networks'].forEach((v) {
        networks.add(new Networks.fromJson(v));
      });
    }
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['first_air_date'] = this.firstAirDate;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['name'] = this.title;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    if (this.networks != null) {
      data['networks'] = this.networks.map((v) => v.toJson()).toList();
    }
    data['popularity'] = this.popularity;
    return data;
  }
}

class Networks {
  int id;
  Logo logo;
  String name;
  String originCountry;

  Networks({this.id, this.logo, this.name, this.originCountry});

  Networks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class Logo {
  String path;
  double aspectRatio;

  Logo({this.path, this.aspectRatio});

  Logo.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    aspectRatio = json['aspect_ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['aspect_ratio'] = this.aspectRatio;
    return data;
  }
}

String _url(int id) =>
    'https://api.themoviedb.org/3/tv/$id/recommendations?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US&page=1#';

Future<RecommendationsSeries> getRecommendationsSeries(int id) async {
  http.Response futurePost = await http.get(_url(id));
  if (futurePost.statusCode == 200) {
    return RecommendationsSeries.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}
