import 'package:firebase_auth/firebase_auth.dart' as auth;
class SignUpService{
  Future<auth.User?> signUp(String email,String password) async{
    auth.UserCredential credential = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    // ignore: unnecessary_null_comparison
    if(credential==null){
      throw Exception('Sign Up Failed');
    }else{
      return credential.user;
    }
  }
}