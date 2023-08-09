import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/models/cart_model.dart';
import 'package:firebase_learning/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // @override
  // void onInit() {
  //   getProductsInCart().then((value) => getQtyAndTotal());
  //   super.onInit();
  // }

  final qty = 0.obs;
  final total = 0.0.obs;

  final cart = <ProductModel>[].obs;

  Future<void> addProductToCart(ProductModel product, String userId) async {
    product.qty = 1;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .add({
      "allCarts": [product.toMap()]
    });
    print('Product added to cart');
  }

  Future<void> getProductsInCart() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get();
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(snapshot.docs[0].id)
        .get();
      for(var e in snap['allCarts']){
        cart.add(ProductModel.fromMap(e));
      }
    print(cart.length);
  }

  // Future<void> removeProductInCart(ProductModel product, String userId) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .collection("cart")
  //       .doc(product.id)
  //       .delete();
  // }

  // Future<void> increaseQty(ProductModel product, String userId) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .collection("cart")
  //       .doc(product.id)
  //       .update({"qty": FieldValue.increment(1)});
  // }
  //
  // Future<void> decreaseQty(ProductModel product, String userId) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .collection("cart")
  //       .doc(product.id)
  //       .update({"qty": (product.qty)!-1});
  // }
  // Future<void> getQtyAndTotal() async{
  //   qty.value = cart.map((element) => element.qty!).reduce((value, element) => value+element);
  //   total.value = cart.map((element) => (element.qty)!*(element.price)!).reduce((value, element) => value+element);
  // }
}
