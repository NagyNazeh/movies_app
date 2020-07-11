import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/grid_view_screen.dart';
import 'package:movies_app/ui/widgets/card_item_widget.dart';

class CardWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final String title;
  final bool isMovie;

  CardWidget(this.snapshot, this.title, this.isMovie);

  void seeMore(BuildContext context) {
    Navigator.pushNamed(
      context,
      GridViewScreen.routeName,
      arguments: {'title': title, 'snapshot': snapshot, 'isMovie': isMovie},
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mQ = MediaQuery.of(context);
    final _tO = Theme.of(context);
    final _height = _mQ.size.height * 0.50;
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
              style: _tO.textTheme.body1,
            ),
            onTap: () => seeMore(context),
          ),
        ],
      ),
    );
    Widget validSnapshot(int index) {
      if (snapshot.hasData) {
        return Container(
          width: _mQ.size.width * 0.4,
          height: _height * 0.8,
          child: CardItemWidget(snapshot, index, isMovie),
        );
      } else if (snapshot.hasError) return Text('${snapshot.error}');
      return Container(
        width: _mQ.size.width * 0.4,
        height: _height * 0.8,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: _mQ.size.width,
      height: _height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: _tO.primaryColorLight),
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
          // Divider(color: Colors.white,),
        ],
      ),
    );
  }
}
