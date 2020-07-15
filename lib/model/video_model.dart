import 'dart:convert';

import 'package:http/http.dart' as http;

class Video {
  int id;
  List<Results> results;

  Video({this.id, this.results});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Results(
      {this.id,
      this.iso6391,
      this.iso31661,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

String _urlVideo(int id) =>
    'https://api.themoviedb.org/3/movie/$id/videos?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US';

Future<Video> getVideoMovie(int id) async {
  http.Response futurePost = await http.get(_urlVideo(id));
  if (futurePost.statusCode == 200) {
    return Video.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}

String _urlSeries(int id) =>
    'https://api.themoviedb.org/3/tv/$id/videos?api_key=69c460550e20df77b6d9d40422d53af1&language=en-US';

Future<Video> getVideoSeries(int id) async {
  http.Response futurePost = await http.get(_urlSeries(id));
  if (futurePost.statusCode == 200) {
    return Video.fromJson(json.decode(futurePost.body));
  } else {
    throw Exception('cant load');
  }
}
