import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/movie_details_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movies-details-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final argId = routeArgs['id'];
    final argTitle = routeArgs['title'];
    String title = 'ad stars';
    return Scaffold(
      appBar: AppBar(
        title: Text(argTitle),
      ),
      body: MovieDetailsWidget(argId),
    );
  }
}
