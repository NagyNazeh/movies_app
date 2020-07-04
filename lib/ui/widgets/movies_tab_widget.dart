import 'package:flutter/material.dart';

class MoviesTabWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final String title;

  MoviesTabWidget(this.snapshot, this.title);

  void seeMore() {}

  void cardMovieTap() {}

  @override
  Widget build(BuildContext context) {
    final _mQ = MediaQuery.of(context);
    final _tO = Theme.of(context);
    final _height = _mQ.size.height * 0.45;
    final _image = 'https://image.tmdb.org/t/p/w500';
    final _borderRadius = BorderRadius.circular(20);
    final _rowTitle = Container(
      height: _height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            // ignore: deprecated_member_use
            style: _tO.textTheme.title,
          ),
          InkWell(
            child: Text(
              'See More',
              // ignore: deprecated_member_use
              style: _tO.textTheme.title.copyWith(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.greenAccent,
              ),
            ),
            onTap: seeMore,
          ),
        ],
      ),
    );
    Widget validSnapshot(int index) {
      if (snapshot.hasData) {
        return InkWell(
          onTap: cardMovieTap,
          child: Container(
            decoration: BoxDecoration(borderRadius: _borderRadius),
            width: _mQ.size.width * 0.4,
            height: _height * 0.8,
            child: Card(
              color: _tO.primaryColorLight,
              shape: RoundedRectangleBorder(borderRadius: _borderRadius),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Image.network(
                    '$_image${snapshot.data.results[index].posterPath}',
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
          ),
        );
      } else if (snapshot.hasError) return Text('${snapshot.error}');
      return CircularProgressIndicator();
    }

    return Container(
      width: _mQ.size.width,
      height: _height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _tO.primaryColorLight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _rowTitle,
          Container(
            height: _height * 0.8,
            width: _mQ.size.width,
            decoration: BoxDecoration(borderRadius: _borderRadius),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return validSnapshot(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
