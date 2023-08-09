import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late int userId;
  late String userName;
  late String password;
  UserModel({
    required this.userId,
    required this.userName,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {'user_id': userId, 'user_name': userName, 'password': password};
  }

  UserModel.fromDucumentSnapShot(DocumentSnapshot ref)
      : userId = ref['user_id'],
        userName = ref['user_name'],
        password = ref['password'];
}