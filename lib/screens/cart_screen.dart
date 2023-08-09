// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_learning/controllers/cart_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cartController = Get.put(CartController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Products In Cart'),
//       ),
//       body: Obx(
//         () => cartController.cart.isNotEmpty
//             ? Column(
//                 children: List.generate(
//                   cartController.cart.length,
//                   (index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 60,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.black.withOpacity(0.1)),
//                         child: Row(
//                           children: [
//                             Expanded(
//                                 flex: 2,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: 75,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           borderRadius: const BorderRadius.only(
//                                               topLeft: Radius.circular(10),
//                                               bottomLeft: Radius.circular(10)),
//                                           image: DecorationImage(
//                                               image: NetworkImage(cartController
//                                                   .cart[index].image![0]))),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '${cartController.cart[index].name}',
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               '\$${cartController.cart[index].price}',
//                                               style: const TextStyle(
//                                                   decoration: TextDecoration
//                                                       .lineThrough,
//                                                   color: Colors.grey),
//                                             ),
//                                             const SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text(
//                                               '\$${cartController.cart[index].discount}',
//                                               style: const TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: 17),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )),
//                             Expanded(
//                                 flex: 1,
//                                 child: Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//
//                                       },
//                                       child: const Icon(Icons.remove),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     // Obx(() => Text(
//                                     //     '${cartController.cart[index].qty}')),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//
//                                       },
//                                       child: const Icon(Icons.add),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//
//                                       },
//                                       child: const Icon(Icons.delete_forever),
//                                     )
//                                   ],
//                                 ))
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             : const Center(
//                 child: Text('No Products in cart yet'),
//               ),
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         height: 100,
//         decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.1),
//             borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(5), topRight: Radius.circular(5))),
//         child:  Column(
//           children: [
//              Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         const Text('Qty :       '),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Obx(() => Text(' ${cartController.qty} ')),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text('Total : '),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Obx(() => Text(' \$${cartController.total} ')),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//
//                   },
//                   child: const Text('Buy now')
//                   ),
//               )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
