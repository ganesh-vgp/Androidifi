import 'package:flutter/material.dart';
import './bulletin.dart';
import './review_article.dart';
import '../services/fetch_article.dart';

class ReviewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  final FetchArticles _fetchArticles = FetchArticles();
  List<ReviewArticle> _reviewList = List<ReviewArticle>();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchArticles.fetchReviews().then((var reviewList) {
      setState(() {
        _reviewList = reviewList;
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? ListView.builder(
            itemCount: _reviewList.length,
            itemBuilder: (context, index) {
              final Image image = Image.network(
                _reviewList[index].headerImageUrl,
                fit: BoxFit.cover,
                height: 100.0,
                width: MediaQuery.of(context).size.width/3,
              );
              return Container(
                margin: EdgeInsets.all(5.0),
                child: Bulletin(
                  type: _reviewList[index].type,
                  brand: _reviewList[index].brand,
                  model: _reviewList[index].model,
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image,
                  ),
                  index: index,
                  onPress: onPress,
                  subHeading: _reviewList[index].subHeading,
                  timeStamp: _reviewList[index].timeStamp,
                ),
              );
            },
          )
        : Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffDB4437)),
              ),
            ),
          );
  }

  void onPress(BuildContext context, int index) {
    print(index);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewArticle(
          type: _reviewList[index].type,
          brand: _reviewList[index].brand,
          model: _reviewList[index].model,
          headerImageUrl: _reviewList[index].headerImageUrl,
          content: _reviewList[index].content,
          heroTag: index.toString(),
          timeStamp: _reviewList[index].timeStamp,
          rating: _reviewList[index].rating,
        ),
      ),
    );
  }
}
