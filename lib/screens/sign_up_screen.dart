import 'package:firebase_learning/services/sign_up_service.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
var _globalKey = GlobalKey<ScaffoldState>();
class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  showSnackbar(String text) {
    SnackBar(
      content: Text(text) 
    );
  }
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
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
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
                      SignUpService signUpService = SignUpService();
                      signUpService.signUp(emailController.text, passwordController.text).then((value) => Navigator.pop(context));
                  },
                child: const Text('SIGN UP')
               ),
              ),
              const SizedBox(height: 30,),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}