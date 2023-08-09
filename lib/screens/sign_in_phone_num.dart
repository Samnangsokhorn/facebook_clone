import 'package:firebase_learning/screens/success_screen.dart';
import 'package:firebase_learning/services/phone_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
class LoginWithPhoneNum extends StatefulWidget {
  const LoginWithPhoneNum({super.key});

  @override
  State<LoginWithPhoneNum> createState() => _LoginWithPhoneNumState();
}

TextEditingController phoneController = TextEditingController();

class _LoginWithPhoneNumState extends State<LoginWithPhoneNum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign in with phone number'),
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildBody,
        ),);
  }

  get _buildBody {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 450,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPhone,
            _buildSendCode,
          ],
        )
      ),
    );
  }
  final TextEditingController _phoneController = TextEditingController();

  get _buildPhone{
    return Container(
      width: 400,
      height: 50,
      color: Colors.black.withOpacity(0.1),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          prefix: Text('+855')
        ),
      ),
    );
  }
  String getOnlyNumber(String phone){
    if(phone[0] == "0"){
      return phone.substring(1,phone.length);
    }
    return phone;
  }

  get _buildSendCode{
    return ElevatedButton(
      onPressed: () {
        String number = '+855715599071';
        PhoneVerification phoneVerification = PhoneVerification(number, context, (auth.User user){
          // ignore: unnecessary_null_comparison
          if(user == null){
            showDialog(context: context, builder: (context) => Text('Failed'),);
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessScreen(),));
          }
        });
        
      }, 
      child: const Text('Send code')
      );
  }
  
}
