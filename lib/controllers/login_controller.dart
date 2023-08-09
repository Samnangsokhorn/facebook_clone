import 'package:firebase_learning/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  LoginService loginService =LoginService();
  var isLoading = false.obs;
  Future<void> login() async{
    isLoading(true);
    await loginService.signIn(emailController.value.text, passwordController.value.text);
    isLoading(false);
  }
}