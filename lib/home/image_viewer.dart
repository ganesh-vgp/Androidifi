import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final Image image;
  final String heroTag;
  ImageViewer({this.image, this.heroTag});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000).withOpacity(0.75),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          Navigator.of(context).pop();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Hero(
              tag: widget.heroTag,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: widget.image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
