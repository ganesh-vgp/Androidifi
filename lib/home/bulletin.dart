import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';
import '../style.dart';

class Bulletin extends StatelessWidget {
  final String heading;
  final String subHeading;
  final int index;
  final Image image;
  final String timeStamp;
  final void Function(BuildContext, int) onPress;

  Bulletin(
      {this.heading,
      this.subHeading,
      this.onPress,
      this.image,
      this.timeStamp,
      this.index});

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
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Hero(
                      tag: index.toString(),
                      child: image,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: Text(
                              heading,
                              style: Style.text1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _getColorBar(Color(0xff4284f4), context),
                                _getColorBar(Color(0xffDB4437), context),
                                _getColorBar(Color(0xfff4b400), context),
                                _getColorBar(Color(0xff0f9d58), context),
                              ],
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getColorBar(Color color, BuildContext context) {
    return Container(
      color: color,
      height: 7.0,
      width: MediaQuery.of(context).size.width / 5,
    );
  }
}
