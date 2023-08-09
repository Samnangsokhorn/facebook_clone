import 'package:firebase_auth/firebase_auth.dart' as auth;
class LoginService{
  Future<auth.User?> signIn(String email,String password) async{
    auth.UserCredential credential = await auth.FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    // ignore: unnecessary_null_comparison
    if(credential==null){
      throw Exception('Login Failed');
    }else{
      return credential.user;
    }
  }
}