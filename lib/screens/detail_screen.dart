import 'package:firebase_learning/models/product_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
   DetailScreen({super.key,this.pro});
  ProductModel? pro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${pro!.image![0]}')
                )
              ),
            )
          ],
        ) 
      ),
    );
  }
}