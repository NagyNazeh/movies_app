import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/details_screen.dart';
import 'package:movies_app/ui/screens/home_screen.dart';
import 'package:movies_app/ui/screens/movies_tab_screen.dart';
import 'package:movies_app/ui/screens/series_tab_screen.dart';
import 'package:movies_app/util/HexColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: HexColor('#263238'),
        ),
        backgroundColor: HexColor('#4f5b62'),
        primaryColor: HexColor('#263238'),
        primaryColorDark: HexColor('#000a12'),
        primaryColorLight: HexColor('#4f5b62'),
        textTheme: TextTheme().copyWith(
          // ignore: deprecated_member_use
          title: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
          // ignore: deprecated_member_use
          body1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            color: Colors.greenAccent,
          ),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        MoviesTabScreen.routeName: (_) => MoviesTabScreen(),
        SeriesTabScreen.routeName: (_) => SeriesTabScreen(),
        DetailsScreen.routeName: (_) => DetailsScreen(),
      },
    );
  }
}
