import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import '../home/article.dart';

class FetchArticles {
  Future<List<Article>> fetch() async {
    List<Article> articleList = List<Article>();
    fs.Firestore store = fb.firestore();
    await store.collection('Articles').orderBy('timeStamp','desc').get().then((fs.QuerySnapshot snapshot) {
      snapshot.forEach((doc) {
        articleList.add(Article.fromJSON(doc.data()));
      });
    });
    return articleList;
  }
}
