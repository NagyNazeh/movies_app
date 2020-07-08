import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  final id;

  MovieDetailsWidget(this.id);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState(id);
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  final id;

  _MovieDetailsWidgetState(this.id);

  Future<MovieDetails> _dataDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataDetails = getMovieDetails(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<MovieDetails>(
        future: _dataDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text(snapshot.data.originalTitle);
          else if (snapshot.hasError) return Text('${snapshot.error}');
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
