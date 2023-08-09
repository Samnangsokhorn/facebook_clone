import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning/models/user_model.dart';
import 'package:firebase_learning/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login with email',style: TextStyle(color: Colors.blue,fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 50,),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: 'Email'
                  )
                ),
                const SizedBox(height: 10,),
                TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      hintText: 'Password'
                    )
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                        color: Colors.blue,
                        child: const Text('Login'),
                        onPressed: () async{
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text
                            );

                            if(credential.user !=null){
                              Get.offAll(()=> const WelcomeScreen());
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                    ),
                    CupertinoButton(
                        color: Colors.blue,
                        child: const Text('Create'),
                        onPressed: () async{
                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((value) {
                              FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(UserModel(
                                  userId: DateTime.now().microsecondsSinceEpoch,
                                  userName: emailController.text,
                                  password: passwordController.text).toMap());
                            }).then((value) => Get.offAll(()=> const WelcomeScreen()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
