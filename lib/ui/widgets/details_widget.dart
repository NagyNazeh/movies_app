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
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  Future<MovieDetails> _movieDetails;
  Future<SeriesDetails> _seriesDetails;
  Future<RecommendationsMovies> _recommendationsMovies;
  Future<RecommendationsSeries> _recommendationsSeries;
  bool isRecommendations = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isMovie) {
      _movieDetails = getMovieDetails(widget.id);
      _recommendationsMovies = getRecommendationsMovies(widget.id);
      _recommendationsMovies.then((value) {
        if (value.results.isNotEmpty && value.results.length > 11) {
          setState(() {
            isRecommendations = true;
          });
          return true;
        } else
          return true;
      });
    } else {
      _seriesDetails = getSeriesDetails(widget.id);
      _recommendationsSeries = getRecommendationsSeries(widget.id);
      _recommendationsSeries.then((value) {
        if (value.results.isNotEmpty && value.results.length > 11) {
          setState(() {
            isRecommendations = true;
          });
        }
        return true;
      });
    }
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
            DetailsImageWidget(snapshot, widget.isMovie, widget.id),
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
                      DetailsInfoWidget(snapshot, widget.isMovie),
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
                            child: widget.isMovie
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
                      widget.isMovie
                          ? isRecommendations
                              ? FutureBuilder<RecommendationsMovies>(
                                  future: _recommendationsMovies,
                                  builder: (context, snapshot) {
                                    return CardWidget(
                                        snapshot, 'Recommendations', true);
                                  },
                                )
                              : Padding(padding: const EdgeInsets.all(0))
                          : isRecommendations
                              ? FutureBuilder<RecommendationsSeries>(
                                  future: _recommendationsSeries,
                                  builder: (context, snapshot) {
                                    return CardWidget(
                                        snapshot, 'Recommendations', false);
                                  },
                                )
                              : Padding(padding: const EdgeInsets.all(0)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (snapshot.hasError)
      return Text('${snapshot.error} $widget.isMovie');
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(widget.title));
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: widget.isMovie
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
