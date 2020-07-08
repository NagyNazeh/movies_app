import 'package:flutter/material.dart';

class DetailsInfoWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final isMovie;

  DetailsInfoWidget(this.snapshot, this.isMovie);

  @override
  Widget build(BuildContext context) {
    final tO = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${snapshot.data.voteAverage.toString()}/10',
                  // ignore: deprecated_member_use
                  style: tO.textTheme.body1,
                ),
                Icon(
                  Icons.star,
                  color: Colors.greenAccent,
                ),
              ],
            ),
            Text(
              'IMDB',
              // ignore: deprecated_member_use
              style: tO.textTheme.title,
            ),
          ],
        ),
        Divider(color: Colors.white),
        Column(
          children: <Widget>[
            Text(
              snapshot.data.popularity.toString(),
              // ignore: deprecated_member_use
              style: tO.textTheme.body1,
            ),
            Text(
              'Popularity',
              // ignore: deprecated_member_use
              style: tO.textTheme.title,
            ),
          ],
        ),
        Divider(color: Colors.white),
        Column(
          children: <Widget>[
            isMovie
                ? Text(
                    snapshot.data.releaseDate.toString(),
                    // ignore: deprecated_member_use
                    style: tO.textTheme.body1,
                  )
                : Text(
                    snapshot.data.firstAirDate.toString(),
                    // ignore: deprecated_member_use
                    style: tO.textTheme.body1,
                  ),
            isMovie
                ? Text(
                    'Date',
                    // ignore: deprecated_member_use
                    style: tO.textTheme.title,
                  )
                : Text(
                    'First Show',
                    // ignore: deprecated_member_use
                    style: tO.textTheme.title,
                  ),
          ],
        ),
      ],
    );
  }
}
