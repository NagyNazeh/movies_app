import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_details_model.dart';
import 'package:movies_app/model/movie_recommendations_model.dart';
import 'package:movies_app/model/series_details_model.dart';
import 'package:movies_app/model/series_recommendations_model.dart';
import 'package:movies_app/ui/widgets/card_widget.dart';
import 'package:movies_app/ui/widgets/details_image_widget.dart';
import 'package:movies_app/ui/widgets/details_info_widget.dart';

class DetailsWidget extends StatefulWidget {
  final id;
  final title;
  final isMovie;

  DetailsWidget(this.id, this.title, this.isMovie);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState(id, title, isMovie);
}

class _DetailsWidgetState extends State<DetailsWidget> {
  final _id;
  final _title;
  final _isMovie;

  _DetailsWidgetState(this._id, this._title, this._isMovie);

  Future<MovieDetails> _movieDetails;
  Future<SeriesDetails> _seriesDetails;
  Future<RecommendationsMovies> _recommendationsMovies;
  Future<RecommendationsSeries> _recommendationsSeries;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_isMovie) {
      _movieDetails = getMovieDetails(_id);
      _recommendationsMovies = getRecommendationsMovies(_id);
    } else {
      _seriesDetails = getSeriesDetails(_id);
      _recommendationsSeries = getRecommendationsSeries(_id);
    }
    //_dataRecommendations = getRecommendationsMovies(_id);
  }

  String getGenresMovie(List<GenresMovies> g) {
    String genres = '';
    for (int i = 0; i < g.length; i++) {
      genres += (g[i].name.toString());
      if (i + 1 < g.length) genres += ', ';
    }
    return genres;
  }

  String getGenresSeries(List<GenresSeries> g) {
    String genres = '';
    for (int i = 0; i < g.length; i++) {
      genres += (g[i].name.toString());
      if (i + 1 < g.length) genres += ', ';
    }
    return genres;
  }

  Widget container(AsyncSnapshot snapshot, AppBar appBar) {
    final mQ = MediaQuery.of(context);
    final tO = Theme.of(context);
    if (snapshot.hasData) {
      return Container(
        color: tO.primaryColorLight,
        child: Column(
          children: <Widget>[
            DetailsImageWidget(snapshot, _isMovie),
            Container(
              height: (mQ.size.height * 0.7) -
                  appBar.preferredSize.height -
                  mQ.padding.top,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DetailsInfoWidget(snapshot, _isMovie),
                      Divider(color: Colors.white),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Category : ',
                            // ignore: deprecated_member_use
                            style: tO.textTheme.title,
                          ),
                          Expanded(
                            child: _isMovie
                                ? Text(
                                    getGenresMovie(snapshot.data.genres),
                                    // ignore: deprecated_member_use
                                    style: tO.textTheme.body1,
                                  )
                                : Text(
                                    getGenresSeries(snapshot.data.genres),
                                    // ignore: deprecated_member_use
                                    style: tO.textTheme.body1,
                                  ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Overview : ',
                            // ignore: deprecated_member_use
                            style: tO.textTheme.title,
                            // ignore: deprecated_member_use
                          ),
                          Expanded(
                            child: Text(
                              snapshot.data.overview,
                              // ignore: deprecated_member_use
                              style: tO.textTheme.body1,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white),
                      _isMovie
                          ? FutureBuilder<RecommendationsMovies>(
                              future: _recommendationsMovies,
                              builder: (context, snapshot) {
                                return CardWidget(
                                    snapshot, 'Recommendations', true);
                              },
                            )
                          : FutureBuilder<RecommendationsSeries>(
                              future: _recommendationsSeries,
                              builder: (context, snapshot) {
                                return CardWidget(
                                    snapshot, 'Recommendations', false);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (snapshot.hasError) return Text('${snapshot.error} $_isMovie');
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(_title));
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: _isMovie
            ? FutureBuilder<MovieDetails>(
                future: _movieDetails,
                builder: (context, snapshot) {
                  return container(snapshot, appBar);
                },
              )
            : FutureBuilder<SeriesDetails>(
                future: _seriesDetails,
                builder: (context, snapshot) {
                  return container(snapshot, appBar);
                },
              ),
      ),
    );
  }
}
