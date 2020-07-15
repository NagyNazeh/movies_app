import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_app/ui/screens/details_screen.dart';

class CardItemWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  final bool isMovie;

  CardItemWidget(this.snapshot, this.index, this.isMovie);

  void cardTap(BuildContext context, int id, String title, bool isMovie) {
    Navigator.pushNamed(
      context,
      DetailsScreen.routeName,
      arguments: {'id': id, 'title': title, 'isMovie': isMovie},
    );
  }

  String imagePath(String path) {
    if (path != null)
      return path;
    else
      return '/1RNeizGR78KuShMEE8rAyTXooAI.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final _tO = Theme.of(context);
    final _image = 'https://image.tmdb.org/t/p/w500';
    return InkWell(
      onTap: () => cardTap(
        context,
        snapshot.data.results[index].id,
        snapshot.data.results[index].title,
        isMovie,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 5),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Image.network(
                  '$_image${imagePath(snapshot.data.results[index].posterPath)}',
                  fit: BoxFit.cover,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.greenAccent,
                      size: 70,
                    ),
                    Text(
                      snapshot.data.results[index].voteAverage.toString(),
                      style: TextStyle(
                        color: _tO.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                snapshot.data.results[index].title,
                maxLines: 2,
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
