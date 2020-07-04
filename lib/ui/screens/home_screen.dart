import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/movies_tab_screen.dart';
import 'package:movies_app/ui/screens/series_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text('Movies App'),
      bottom: TabBar(
        indicatorColor: Colors.greenAccent,
        indicatorWeight: 2,
        labelColor: Colors.greenAccent,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: Colors.grey.shade400,
        tabs: <Widget>[
          Tab(text: 'Movies'),
          Tab(text: 'Series'),
        ],
      ),
    );
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: _appBar,
        body: TabBarView(
          children: <Widget>[
            MoviesTabScreen(),
            SeriesTabScreen(),
          ],
        ),
      ),
    );
  }
}
