import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import './data/mock_data.dart';
import './style.dart';
import './menu_item.dart';
import './home/home.dart';
import './about_us/about_us.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Androidifi',
      home: Androidifi(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Montserrat',
      ),
    ),
  );
}

class Androidifi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AndroidifiState();
}

class _AndroidifiState extends State<Androidifi> {
  final List<Map<String, dynamic>> _menuItems = MockData.menuItems;
  final String logoUrl = 'assets/images/logo.png';

  int _index = 0;

  List<Color> _colors = [];
  List<Color> _dimColors = [];
  List<IconData> _icons = [];
  List<bool> _isSelected = [true];

  List<Widget> _pages = [
    Home(),
    Center(child: Image.asset('assets/images/empty_state.png')),
    Center(child: Image.asset('assets/images/empty_state.png')),
    AboutUs(),
  ];

  @override
  void initState() {
    for (int i = 0; i < _menuItems.length; i++) {
      _colors.add(Color(_menuItems[i]["color"]));
      _dimColors.add(Color(_menuItems[i]["dimColor"]));
      _icons.add(_menuItems[i]["icon"]);
      if (i > 0) {
        _isSelected.add(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _index == 0 ? 'ANDROIDIFI' : _menuItems[_index]["name"],
          style: Style.heading,
        ),
        centerTitle: true,
        backgroundColor: _colors[_index],
        iconTheme: Style.iconTheme,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.instagram,),
            onPressed: () async{
              final String url='https://www.instagram.com/androidifi';
              if(await canLaunch(url)){
                await launch(url);
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                logoUrl,
                height: 200.0,
                width: 200.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 2.0,
                ),
              )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  return MenuItem(
                    name: _menuItems[index]["name"],
                    icon: _menuItems[index]["icon"],
                    color: _isSelected[index]
                        ? _dimColors[index]
                        : Colors.transparent,
                    isSelected: _isSelected[index],
                    function: _select,
                    index: index,
                  );
                },
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_index],
    );
  }

  void _select(int index) {
    setState(() {
      _index = index;
      _isSelected.clear();
      _isSelected = [
        false,
        false,
        false,
        false,
      ];
      _isSelected[index] = true;
    });
    Navigator.pop(context);
  }
}
