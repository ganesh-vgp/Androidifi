import 'package:flutter/material.dart';
import './bulletin.dart';
import './article.dart';
import '../services/fetch_article.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FetchArticles _fetchArticles = FetchArticles();
  List<Article> _articleList = List<Article>();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchArticles.fetch().then((List<Article> articleList) {
      setState(() {
        _articleList = articleList;
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? ListView.builder(
            itemCount: _articleList.length,
            itemBuilder: (context, index) {
              final Image image = Image.network(
                _articleList[index].headerImageUrl,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height/3.75,
                width: double.infinity,
              );
              return Container(
                margin: EdgeInsets.all(5.0),
                child: Bulletin(
                  heading: _articleList[index].heading,
                  image: image,
                  timeStamp: _articleList[index].timeStamp,
                  index: index,
                  onPress: this.onPress,
                ),
              );
            },
          )
        : Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
  }

  void onPress(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Article(
          heading: _articleList[index].heading,
          headerImageUrl: _articleList[index].headerImageUrl,
          content: _articleList[index].content,
          links: _articleList[index].links,
          heroTag: index.toString(),
          timeStamp: _articleList[index].timeStamp,
        ),
      ),
    );
  }
}
