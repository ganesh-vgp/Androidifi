import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './image_viewer.dart';
import '../style.dart';

class ReviewArticle extends StatefulWidget {
  final String type;
  final String brand;
  final String model;
  final String subHeading;
  final String timeStamp;
  final String content;
  final String heroTag;
  final String headerImageUrl;
  final String rating;
  ReviewArticle({
    this.type,
    this.brand,
    this.model,
    this.subHeading,
    this.headerImageUrl,
    this.content,
    this.heroTag,
    this.timeStamp,
    this.rating,
  });

  factory ReviewArticle.fromJSON(Map<String, dynamic> json) {
    return ReviewArticle(
      type: json['type'],
      brand: json['brand'],
      model: json['model'],
      subHeading: json['subHeading'],
      timeStamp: json['timeStamp'],
      content: json['content'],
      headerImageUrl: json['headerImageUrl'],
      rating: json['rating'],
    );
  }

  @override
  _ReviewArticleState createState() => _ReviewArticleState();
}

class _ReviewArticleState extends State<ReviewArticle> {
  StringBuffer _shareContent = StringBuffer();

  final List<String> _catagories = [
    'Design',
    'Performance',
    'Battery Life',
    'Camera',
    'Value for money',
    'Overall',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xffDB4437),
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
    //_shareContent.write('Article posted by Androidifi\n');
    //_shareContent.write('\n*' + widget.heading + '*\n');
    widgetList.add(
      Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.type.trim(),
              style: Style.type,
              textAlign: TextAlign.left,
            ),
            Text(
              widget.brand.trim() + ' ' + widget.model.trim(),
              style: Style.phoneModel,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 5.0,
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
    List<String> ratings = widget.rating.split(',');
    Widget ratingWidget = GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _catagories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (_, index) =>
            _getratingBar(ratings[index], _catagories[index]));
    List<String> list = widget.content.split('|');
    widgetList.add(ratingWidget);
    widgetList.add(Divider(
      color: Colors.grey,
      endIndent: 10.0,
      height: 2,
      indent: 10.0,
      thickness: 0.7,
    ));
    widgetList.add(
      SizedBox(
        height: 5.0,
      ),
    );
    for (String s in list) {
      widgetList.add(
        Container(
          margin: EdgeInsets.all(10.0),
          child: _split(s),
        ),
      );
    }
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

  Widget _getratingBar(String value, String catagory) {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 5.0,
      animation: true,
      animationDuration: 1000,
      percent: double.parse(value) / 10,
      center: Text(
        (double.parse(value)).toString() + '/10'.trim(),
        style: TextStyle(fontSize: 18.0, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      footer: Text(
        catagory,
        style: TextStyle(fontSize: 18.0, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      progressColor: Color(0xffDB4437),
    );
  }
}
