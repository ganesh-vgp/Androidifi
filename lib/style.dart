import 'package:flutter/material.dart';

class Style {
  static final TextStyle heading = TextStyle(
    fontSize: 30.0,
    fontFamily: 'GoogleSans',
    color: Color(0xff5f6368),
    fontWeight: FontWeight.bold,
  );

  static final TextStyle articleHeading = TextStyle(
    fontSize: 30.0,
    fontFamily: 'GoogleSans',
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle tabLabel = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'GoogleSans'
  );
  static final TextStyle articleSubHeading = TextStyle(
    fontSize: 25.0,
    fontFamily: 'GoogleSans',
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle text1 = TextStyle(
    fontSize: 16.0,
    fontFamily: 'GoogleSans',
    color: Colors.black,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
  );

  static final TextStyle text2 = TextStyle(
    fontSize: 14.0,
    fontFamily: 'GoogleSans',
    color: Colors.grey[850],
    backgroundColor: Colors.transparent,
  );

  static final TextStyle innerText = TextStyle(
    fontSize: 18.0,
    fontFamily: 'GoogleSans',
    color: Colors.black,
  );

  static final IconThemeData iconTheme = IconThemeData(
    color: Color(0xff5f6368),
  );

  static final TextStyle sliverHeading = TextStyle(
    fontSize: 20.0,
    fontFamily: 'GoogleSans',
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static final Color primaryColor = Color(0xff4285f4);

  static final TextStyle name = TextStyle(
    fontSize: 25.0,
    fontFamily: 'GoogleSans',
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle role = TextStyle(
    fontSize: 20.0,
    fontFamily: 'GoogleSans',
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );

  static final TextStyle link = TextStyle(
    fontSize: 18,
    color: Color(0xff3ddc84),
    fontWeight: FontWeight.bold,
    fontFamily: 'GoogleSans',
    decoration: TextDecoration.underline,
  );
}
