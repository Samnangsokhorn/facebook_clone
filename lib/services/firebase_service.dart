import 'package:firebase_learning/models/arcticles_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseSevice {
  List<Article> getArticles( List<QueryDocumentSnapshot> docs) {
    List<Article> articles = docs.map((e) => Article.fromSnapshot(e)).toList();
    return articles;
  }
  insertArticle(Article article) async{
    FirebaseFirestore.instance.runTransaction(
      (transaction) async{
        CollectionReference colRef = FirebaseFirestore.instance.collection("articles");
        await colRef.add(article.toMap);
      },
    ).then((value) => print('Article added'));
  }
  updateArticle(DocumentReference reference,Article article) async{
    FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.update(reference, article.toMap);
    }).then((value) => print('Update successful.'));
  }
  deleteArticle(DocumentReference reference) async{
    FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.delete(reference);
    }).then((value) => print('Deleted.'));
  }
}
