import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/controllers/cart_controller.dart';
import 'package:firebase_learning/models/product_model.dart';
import 'package:firebase_learning/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 80,
                  height: 60,
                ),
                const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                Positioned(
                  left: 43,
                  bottom: 30,
                  child: GestureDetector(
                    onTap: () {
                      cartController.getProductsInCart();
                      // Get.to(() => const CartScreen());
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: const Center(
                          child: Text('1')),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=> SuccessScreen());
        } ,
        child: Icon(Icons.image_outlined),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          List<ProductModel> pro = snapshot.data!.docs
              .map((e) => ProductModel.fromSnapshot(e))
              .toList();
          if (snapshot.hasError) {
            return const Center(
                child: Icon(
              Icons.info,
              color: Colors.red,
              size: 30,
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return pro.isEmpty
                ? const SizedBox(
                    child: Text('No data...'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: List.generate(
                        pro.length,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 0.5)),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage('${pro[index].image![0]}')
                                          )
                                      ),
                                    )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${pro[index].name}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '\$ ${pro[index].price}',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '\$${pro[index].discount}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // productController
                                          //     .addProductToCart(
                                          //         pro[index],
                                          //         FirebaseAuth.instance
                                          //             .currentUser!.uid);
                                        },
                                        child: const CircleAvatar(
                                          child: Icon(
                                              Icons.shopping_cart_outlined),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}
