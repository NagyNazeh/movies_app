import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/card_item_widget.dart';

class GridViewScreen extends StatelessWidget {
  static const routeName = '/grid-view-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final argTitle = routeArgs['title'];
    final argIsMove = routeArgs['isMovie'];
    final argSnapShot = routeArgs['snapshot'];
    return Scaffold(
      appBar: AppBar(
        title: Text(argTitle),
      ),
      body: Container(
        color: Theme.of(context).primaryColorLight,
        child: GridView.builder(
          padding: const EdgeInsets.all(25),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            childAspectRatio: 1.8 / 3.2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 0,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return CardItemWidget(argSnapShot, index, argIsMove);
          },
        ),
      ),
    );
  }
}
