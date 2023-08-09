import 'package:firebase_learning/controllers/login_controller.dart';
import 'package:firebase_learning/screens/home_screen.dart';
import 'package:firebase_learning/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
var _globalKey = GlobalKey<ScaffoldState>();
class _LoginScreenState extends State<LoginScreen> {
  _showSnackbar(String text) {
    SnackBar(
      content: Text(text) 
    );
  }
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.facebook_outlined,size: 100,color: Colors.blue,),
              const SizedBox(height: 50,),
              TextFormField(
                controller: controller.emailController.value,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: controller.passwordController.value,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30,),
               SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                      controller.login().then((user){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                      }
                    );
                  },
                child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) : const Text('SIGN IN')
               ),
              ),
              const SizedBox(height: 30,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
                },
                child: const Text('Go to sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}