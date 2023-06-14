import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';

class AuthServices {
  //Google Sign In
  signInWithGoogle() async {
    // being interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finaly lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}