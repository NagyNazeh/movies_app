import 'package:flutter/material.dart';

class DetailsImageWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final isMovie;

  DetailsImageWidget(this.snapshot, this.isMovie);

  String imagePath() {
    if (snapshot.data.backdropPath != null)
      return snapshot.data.backdropPath;
    else if (snapshot.data.posterPath != null)
      return snapshot.data.posterPath;
    else
      return '/1RNeizGR78KuShMEE8rAyTXooAI.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final image = 'https://image.tmdb.org/t/p/w500';
    final tO = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: Container(
        height: mQ.size.height * 0.3,
        width: mQ.size.width,
        color: tO.primaryColorLight,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            SizedBox(
              width: mQ.size.width,
              child: Image.network(
                '$image${imagePath()}',
                fit: BoxFit.cover,
              ),
            ),
            isMovie
                ? Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : Padding(padding: EdgeInsets.all(0)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                snapshot.data.title,
                // ignore: deprecated_member_use
                style: tO.textTheme.title
                    .copyWith(backgroundColor: tO.primaryColorLight),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
