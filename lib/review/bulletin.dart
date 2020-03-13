import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';
import '../style.dart';

class Bulletin extends StatelessWidget {
  final int index;
  final String type;
  final String brand;
  final String model;
  final String subHeading;
  final Widget image;
  final String timeStamp;
  final void Function(BuildContext, int) onPress;

  Bulletin(
      {this.index,
      this.type,
      this.brand,
      this.model,
      this.subHeading,
      this.image,
      this.timeStamp,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onPress(context, this.index),
      splashColor: Colors.grey[350],
      borderRadius: BorderRadius.circular(5.0),
      child: Material(
        elevation: 0.0,
        color: Colors.transparent,
        child: Card(
          color: Colors.transparent,
          elevation: 1.0,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        type,
                        style: Style.review,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        brand,
                        style: Style.review,
                      ),
                      Text(
                        model,
                        style: Style.review,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        subHeading,
                        style: Style.articleSubHeading,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Hero(
                        tag: index.toString(),
                        child: image,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: Text(
                            formatTime(int.parse(this.timeStamp)),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
