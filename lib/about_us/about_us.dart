import 'package:flutter/material.dart';
import '../data/about.dart';
import './bulletin.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Map<String, String>> _aboutData = List<Map<String, String>>();
  @override
  void initState() {
    _aboutData = About.about;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: _aboutData.length,
        itemBuilder: (context, index) => Bulletin(
          imageUrl: _aboutData[index]["imageUrl"],
          instaUrl: _aboutData[index]["instaUrl"],
          name: _aboutData[index]["name"],
          role: _aboutData[index]["role"],
        ),
        shrinkWrap: true,
      ),
    );
  }
}
