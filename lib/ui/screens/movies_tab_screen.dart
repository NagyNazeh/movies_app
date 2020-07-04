import 'package:flutter/material.dart';
import 'package:movies_app/model/movies_popular_model.dart';
import 'package:movies_app/model/movies_top_rated_model.dart';
import 'package:movies_app/model/movies_up_coming_model.dart';
import 'package:movies_app/ui/widgets/movies_tab_widget.dart';

class MoviesTabScreen extends StatefulWidget {
  static const routeName = '/movies-tab-screen';

  @override
  _MoviesTabScreenState createState() => _MoviesTabScreenState();
}

class _MoviesTabScreenState extends State<MoviesTabScreen> {
  Future<PopularMovies> _dataPopular;
  Future<TopRatedMovies> _dataTopRated;
  Future<UpComingMovies> _dataUpComing;

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
        children: <Widget>[
          FutureBuilder<PopularMovies>(
            future: _dataPopular,
            builder: (context, snapshot) {
              return MoviesTabWidget(snapshot, 'Popular');
            },
          ),
          FutureBuilder<TopRatedMovies>(
            future: _dataTopRated,
            builder: (context, snapshot) {
              return MoviesTabWidget(snapshot, 'Top Rated');
            },
          ),
          FutureBuilder<UpComingMovies>(
            future: _dataUpComing,
            builder: (context, snapshot) {
              return MoviesTabWidget(snapshot, 'Up Coming');
            },
          ),
        ],
      ),
    );
  }
}
