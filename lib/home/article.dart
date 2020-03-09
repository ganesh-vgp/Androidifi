import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:link/link.dart';
import './image_viewer.dart';
import '../style.dart';

class Article extends StatefulWidget {
  final String heading;
  final String headerImageUrl;
  final String content;
  final String links;
  final String timeStamp;
  final String heroTag;
  Article({
    this.heading,
    this.headerImageUrl,
    this.content,
    this.links,
    this.heroTag,
    this.timeStamp,
  });

  factory Article.fromJSON(Map<String, dynamic> json) {
    return Article(
      heading: json['heading'],
      headerImageUrl: json['headerImageUrl'],
      content: json['content'],
      links: json['links'],
      timeStamp: json['timeStamp'],
    );
  }

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  StringBuffer _shareContent = StringBuffer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 2.0,
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.heroTag,
                child: Image.network(
                  widget.headerImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _listBuilder(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff25d366),
        onPressed: () {
          _share();
        },
        isExtended: true,
        child: Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
          size: 30.0,
        ),
        elevation: 2.0,
      ),
    );
  }

  Widget _split(String contents) {
    if (contents.contains('url')) {
      final String tag = contents.substring(26, 33);
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: InkWell(
          onTap: () => _openImage(
            Image.network(
              contents.substring(6),
            ),
            tag,
          ),
          splashColor: Colors.grey[350],
          child: Hero(
            tag: tag,
            child: Image.network(
              contents.substring(6),
            ),
          ),
        ),
      );
    } else if (contents.contains('~')) {
      final String subHeading =
          ('\n\n*' + contents.substring(4)).trim() + '*\n';
      _shareContent.writeln(subHeading);
      return Text(
        contents.substring(4).trim(),
        style: Style.articleSubHeading,
        textAlign: TextAlign.left,
      );
    }
    _shareContent.write('\n' + contents);
    return Text(
      contents.trim(),
      style: Style.innerText,
      textAlign: TextAlign.left,
    );
  }

  List<Widget> _listBuilder() {
    List<Widget> widgetList = List<Widget>();
    _shareContent.write('Article posted by Androidifi\n');
    _shareContent.write('\n*' + widget.heading + '*\n');
    widgetList.add(
      Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.heading.trim(),
              style: Style.articleHeading,
              textAlign: TextAlign.left,
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
                Text(
                  formatTime(int.parse(widget.timeStamp)),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    List<String> list = widget.content.split('|');
    for (String s in list) {
      widgetList.add(
        Container(
          margin: EdgeInsets.all(10.0),
          child: _split(s),
        ),
      );
    }
    List<String> eLinks = widget.links.split('|');
    List<Widget> linkWidgets = List<Widget>();
    int count = 1;
    int length = eLinks.length;
    for (String eLink in eLinks) {
      final RegExp regExp = new RegExp(
          r'(?:[-a-zA-Z0-9@:%_\+~.#=]{2,256}\.)?([-a-zA-Z0-9@:%_\+~#=]*)\.[a-z]{2,6}\b(?:[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)');
      final match = regExp.firstMatch(eLink);
      final String link = match.group(1);
      print(eLink);
      linkWidgets.add(
        Link(
          url: eLink,
          child: Text(
            link.toUpperCase(),
            style: Style.link,
          ),
          onError: () => print('error'),
        ),
      );
      if (count != length) {
        linkWidgets.add(
          Text(
            '|',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }
      count++;
    }
    widgetList.add(
      Wrap(
        alignment: WrapAlignment.center,
        children: linkWidgets,
        spacing: 5.0,
        runSpacing: 5.0,
      ),
    );
    widgetList.add(
      SizedBox(
        height: 80.0,
      ),
    );
    return widgetList;
  }

  void _share() async {
    _shareContent.writeln();
    _shareContent.writeln('\nFor more updates follow Androidifi!');
    _shareContent.writeln();
    _shareContent.writeln('Instagram: www.instagram.com/androidifi');
    _shareContent.writeln();
    _shareContent.writeln('Website: androidifi.web.app');
    _shareContent.writeln();
    String url =
        'https://api.whatsapp.com/send?text=' + _shareContent.toString();
    String whatsappLink = Uri.encodeFull(url);
    if (await canLaunch(whatsappLink)) {
      await launch(whatsappLink);
    }
  }

  void _openImage(Image image, String tag) async {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, e, a) => ImageViewer(
          image: image,
          heroTag: tag,
        ),
      ),
    );
  }
}
