import 'package:flutter/material.dart';
import 'package:movies_app/model/movies_model.dart';
import 'package:movies_app/ui/widgets/card_widget.dart';

class MoviesTabScreen extends StatefulWidget {
  static const routeName = '/movies-tab-screen';

  @override
  _MoviesTabScreenState createState() => _MoviesTabScreenState();
}

class _MoviesTabScreenState extends State<MoviesTabScreen> {
  Future<Movies> _dataPopular;
  Future<Movies> _dataTopRated;
  Future<Movies> _dataUpComing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataPopular = getPopularMovies();
    _dataTopRated = getTopRatedMovies();
    _dataUpComing = getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FutureBuilder<Movies>(
            future: _dataPopular,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'Popular', true);
            },
          ),
          FutureBuilder<Movies>(
            future: _dataTopRated,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'Top Rated', true);
            },
          ),
          FutureBuilder<Movies>(
            future: _dataUpComing,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'Up Coming', true);
            },
          ),
        ],
      ),
    );
  }
}
