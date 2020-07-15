import 'package:flutter/material.dart';
import 'package:movies_app/model/video_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsImageWidget extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final isMovie;
  final id;

  DetailsImageWidget(this.snapshot, this.isMovie, this.id);

  @override
  _DetailsImageWidgetState createState() => _DetailsImageWidgetState();
}

class _DetailsImageWidgetState extends State<DetailsImageWidget> {
  Future<Video> _video;
  bool isVideo = false;
  String keyVideo = 'null';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isMovie) {
      _video = getVideoMovie(widget.id);
    } else {
      _video = getVideoSeries(widget.id);
    }
    _video.then((value) {
      if (value.results.isNotEmpty) {
        if (value.results[0].site == 'YouTube') {
          setState(() {
            isVideo = true;
            keyVideo = value.results[0].key;
          });
        }
        return true;
      } else
        return false;
    });
  }

  String imagePath() {
    if (widget.snapshot.data.backdropPath != null)
      return widget.snapshot.data.backdropPath;
    else if (widget.snapshot.data.posterPath != null)
      return widget.snapshot.data.posterPath;
    else
      return '/1RNeizGR78KuShMEE8rAyTXooAI.jpg';
  }

  void launchURL(String key) async {
    String urlString = 'https://www.youtube.com/watch?v=$keyVideo';
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final image = 'https://image.tmdb.org/t/p/w500';
    final tO = Theme.of(context);
    return InkWell(
      onTap: () => isVideo ? launchURL(keyVideo) : {},
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
            isVideo
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
                widget.snapshot.data.title,
                // ignore: deprecated_member_use
                style: tO.textTheme.title
                    .copyWith(backgroundColor: Colors.black45),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
