import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learning/FacebookClone/model/like_model.dart';

class PostModel {
  String? id;
  LikeModel? like;
  int? comment;
  String? date;
  List<dynamic>? image;
  int? share;
  String? text;
  Map<String, dynamic>? user;

  PostModel(
      {this.id,
      this.user,
      this.text,
      this.image,
      this.date,
      this.comment,
      this.like,
      this.share});

  PostModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : id = snapshot['id'],
        user = snapshot['user'],
        date = snapshot['date'],
        text = snapshot['text'],
        like = LikeModel.fromSnapshot(snapshot['like']),
        image = snapshot['images'],
        comment = snapshot['comment'],
        share = snapshot['share'];
  Map<String, dynamic> toMap() => {
        'id': id,
        'user': user,
        'date': date,
        'text': text,
        'like': like!.toMap(),
        'images': image,
        'comment': comment,
        'share': share
      };
}


