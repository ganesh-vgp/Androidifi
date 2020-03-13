import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import './data/mock_data.dart';
import './style.dart';
import './home/home.dart';
import './review/reviews_list.dart';
import './about_us/about_us.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

void main() {
  final List<Map<String, dynamic>> _menuItems = MockData.menuItems;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Androidifi',
      home: Androidifi(),
      theme: ThemeData(
        primaryColor: Color(_menuItems[0]['color']),
        fontFamily: 'GoogleSans',
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

  List<Widget> _pages = [
    Home(),
    ReviewsList(),
    Center(child: Image.asset('assets/images/empty_state.png')),
    AboutUs(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _menuItems.length,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool isScrolled) {
                  return <Widget>[
                    new SliverAppBar(
                      elevation: 2.0,
                      forceElevated: true,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      automaticallyImplyLeading: false,
                      titleSpacing: 0.0,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          ImageIcon(
                            Image.asset('assets/images/logo.png').image,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Androidifi",
                            style: Style.heading,
                          ),
                        ],
                      ),
                      centerTitle: true,
                      iconTheme: Style.iconTheme,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Color(0xffE1306C),
                          ),
                          onPressed: () async {
                            final String url =
                                'https://www.instagram.com/androidifi';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                        ),
                      ],
                      floating: true,
                      pinned: true,
                      snap: true,
                      bottom: TabBar(
                        labelPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                        tabs: _menuItems
                            .map((e) => Tab(text: e['name']))
                            .toList(),
                        isScrollable: false,
                        onTap: (index) {
                          setState(() {
                            _index = index;
                          });
                        },
                        labelStyle: Style.tabLabel,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Color(_menuItems[_index]['color']),
                        unselectedLabelColor: Color(0xff5f6368),
                        indicator: MD2Indicator(
                          indicatorHeight: 3,
                          indicatorColor: Color(_menuItems[_index]['color']),
                          indicatorSize: MD2IndicatorSize.normal,
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: _pages,
                )),
          );
        },
      ),
    );
  }
}
