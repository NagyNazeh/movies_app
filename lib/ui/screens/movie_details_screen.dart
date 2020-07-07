import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movies-details-screen';

  @override
  Widget build(BuildContext context) {
    String title = 'ad stars';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
