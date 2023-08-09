// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_learning/models/product_model.dart';
// class CartModel{
//   List<ProductModel>? listPro;

//   CartModel({
//      this.listPro
//   });

//   CartModel.fromSnapshot(QueryDocumentSnapshot snapshot){
//     listPro = snapshot['allCarts'].map((e) => ProductModel.fromSnapshot(snapshot));
//   }
// }