import 'package:flutter/material.dart';
import 'package:movies_app/model/series_model.dart';
import 'package:movies_app/ui/widgets/card_widget.dart';

class SeriesTabScreen extends StatefulWidget {
  static const routeName = '/series-tab-screen';

  @override
  _SeriesTabScreenState createState() => _SeriesTabScreenState();
}

class _SeriesTabScreenState extends State<SeriesTabScreen> {
  Future<Series> _dataOnAirSeries;
  Future<Series> _dataPopularSeries;
  Future<Series> _dataTopRatedSeries;

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
          FutureBuilder<Series>(
            future: _dataOnAirSeries,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'On Air Today', false);
            },
          ),
          FutureBuilder<Series>(
            future: _dataPopularSeries,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'Popular', false);
            },
          ),
          FutureBuilder<Series>(
            future: _dataTopRatedSeries,
            builder: (context, snapshot) {
              return CardWidget(snapshot, 'Top Rated', false);
            },
          ),
        ],
      ),
    );
  }
}
