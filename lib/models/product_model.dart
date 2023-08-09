import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  String? description;
  double? discount;
  int? qty;
  double? price;
  List<dynamic>? image;

  ProductModel({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.discount,
    this.image,
    this.description,
  });

  ProductModel.fromSnapshot(QueryDocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        description = snapshot['description'],
        discount = snapshot['discount'],
        price = snapshot['price'],
        image = snapshot['image'];

  ProductModel.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        description = snapshot['description'],
        discount = snapshot['discount'],
        price = snapshot['price'],
        image = snapshot['image'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'qty': qty,
        'discount': discount,
        'image': image
      };
}
