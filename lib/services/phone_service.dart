import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class PhoneVerification {
  final BuildContext context;
  final Function onSuccess;
  PhoneVerification(String number, this.context, this.onSuccess) {
    _verifyPhone(number);
  }
  String _verificationId = "";
  _verifyPhone(String phone) {
    verificationCompleted(auth.AuthCredential credential) async {
      auth.UserCredential userCredential =
          await auth.FirebaseAuth.instance.signInWithCredential(credential);
      _onCompleted(userCredential.user);
    }

    verificationFailed(auth.FirebaseAuthException ex) async {
      print('error${ex.message}');
      _onCompleted(null);
    }

    codeSent(String verid, [int? forceResendingToken]) async {
      _verificationId = verid;
      auth.User user =
          await showDialog(context: context, builder: (context) => _showDialog);
      _onCompleted(user);
    }

    codeAutoRetrievalTimeout(String verid) async {
      _verificationId = verid;
      _onCompleted(null);
    }

    auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  _onCompleted(auth.User? user) {
    if (user != null) {
      onSuccess(user);
    } else {
      onSuccess(null);
    }
  }

  final TextEditingController _smsCode = TextEditingController();
  get _showDialog {
    return AlertDialog(
      title: const Text('Enter Code'),
      content: TextField(
        controller: _smsCode,
        decoration: const InputDecoration(hintText: 'Enter Code'),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              auth.AuthCredential credential =
                  auth.PhoneAuthProvider.credential(
                      verificationId: _verificationId, smsCode: _smsCode.text);
              final userCredential = await auth.FirebaseAuth.instance
                  .signInWithCredential(credential);
              onSuccess(userCredential.user);
            },
            child: const Text("Done"))
      ],
    );
  }
}
