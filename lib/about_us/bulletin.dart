import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../style.dart';

class Bulletin extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String instaUrl;
  final String mail;

  Bulletin({this.imageUrl, this.instaUrl, this.mail, this.name, this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 2.0,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    child: ClipOval(
                      child: Image.network(
                        this.imageUrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    color: Color(0xff55cf86),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            this.name,
                            style: Style.name,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Center(
                          child: Text(
                            this.role,
                            style: Style.role,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(3.0),
              child: IconButton(
                onPressed: () => _urlLauncher(this.instaUrl),
                icon: Icon(FontAwesomeIcons.instagram),
                color: Color(0xffE1306C),
                hoverColor: Colors.grey[400],
                splashColor: Colors.grey[400],
                iconSize: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _urlLauncher(String url) async {
    url = Uri.encodeFull(url);
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('error');
    }
  }
}
