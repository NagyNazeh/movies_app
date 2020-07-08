import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/details_widget.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final argId = routeArgs['id'];
    final argTitle = routeArgs['title'];
    final argIsMove = routeArgs['isMovie'];
    return DetailsWidget(argId, argTitle, argIsMove);
  }
}
