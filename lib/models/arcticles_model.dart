import 'package:cloud_firestore/cloud_firestore.dart';
class Article {
  String? title;
  String? body;
  String? cateid;
  String? date;
  ArticleImage? image;
  DocumentReference? reference;

  Article({
    this.title,
    this.body,
    this.cateid,
    this.date,
    this.image,
    this.reference
  });

  Article.fromMap(Object? obj, {this.reference}){
    Map<String, dynamic>? map = obj as Map<String, dynamic>?;
    title = map!['title'];
    body= map['body'];
    cateid= map['cateid'];
    date= map['date'];
    image= ArticleImage.fromMap(map['image']);
  }
  Article.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(),reference: snapshot.reference);

  Map<String,dynamic> get  toMap =>{
    "title" : title,
    "body" : body,
    "cateid" : cateid,
    "date" : date,
    "image" : image!.toMap,
  };
}
class ArticleImage {
  String? hd; 
  String? sd;
  ArticleImage({
    this.hd,
    this.sd,
  });

  factory ArticleImage.fromMap(Map<dynamic,dynamic> map){
    return ArticleImage(
      hd: map['hd'],
      sd: map['sd']
    );
  }

  Map<String,dynamic> get toMap =>{
    "hd" : hd,
    "sd" : sd
  };
}
