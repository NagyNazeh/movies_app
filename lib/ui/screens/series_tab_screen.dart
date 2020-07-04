import 'package:flutter/material.dart';
import 'package:movies_app/model/series_on_air_model.dart';
import 'package:movies_app/model/series_popular_model.dart';
import 'package:movies_app/model/series_top_rated_model.dart';
import 'package:movies_app/ui/widgets/series_tab_widget.dart';

class SeriesTabScreen extends StatefulWidget {
  static const routeName = '/series-tab-screen';

  @override
  _SeriesTabScreenState createState() => _SeriesTabScreenState();
}

class _SeriesTabScreenState extends State<SeriesTabScreen> {
  Future<OnAirSeries> _dataOnAirSeries;
  Future<PopularSeries> _dataPopularSeries;
  Future<TopRatedSeries> _dataTopRatedSeries;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataOnAirSeries = getOnAirSeries();
    _dataPopularSeries = getPopularSeries();
    _dataTopRatedSeries = getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder<OnAirSeries>(
            future: _dataOnAirSeries,
            builder: (context, snapshot) {
              return SeriesTabWidget(snapshot, 'On Air Today');
            },
          ),
          FutureBuilder<PopularSeries>(
            future: _dataPopularSeries,
            builder: (context, snapshot) {
              return SeriesTabWidget(snapshot, 'Popular');
            },
          ),
          FutureBuilder<TopRatedSeries>(
            future: _dataTopRatedSeries,
            builder: (context, snapshot) {
              return SeriesTabWidget(snapshot, 'Top Rated');
            },
          ),
        ],
      ),
    );
  }
}
