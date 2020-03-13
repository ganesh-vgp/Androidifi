import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import '../home/article.dart';
import '../review/review_article.dart';

class FetchArticles {
  Future<List<Article>> fetchArticles() async {
    List<Article> articleList = List<Article>();
    fs.Firestore store = fb.firestore();
    await store.collection('Articles').orderBy('timeStamp','desc').get().then((fs.QuerySnapshot snapshot) {
      snapshot.forEach((doc) {
        articleList.add(Article.fromJSON(doc.data()));
      });
    });
    return articleList;
  }

  Future<List<ReviewArticle>> fetchReviews() async {
    List<ReviewArticle> articleList = List<ReviewArticle>();
    fs.Firestore store = fb.firestore();
    await store.collection('Reviews').orderBy('timeStamp','desc').get().then((fs.QuerySnapshot snapshot) {
      snapshot.forEach((doc) {
        articleList.add(ReviewArticle.fromJSON(doc.data()));
      });
    });
    return articleList;
  }
}
