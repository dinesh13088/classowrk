import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUserWithAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Something went wrong $e');
    }
    return null;
  }
  Future<User?>loginWithEmailPassword(String email,String password) async{
    try{
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }
    on FirebaseAuthException catch(e)
    {
      print('Something went wrong $e');
    }
    return null;
  }
  // this function is used to logout user form firebase
  void signOutUser() async{
    try{
      _auth.signOut();
    }
    catch(e){
      print("Error while signout $e");
    }
  }

  Future<User?> getLoggedInUser() async{
    //create a completer to handle asynchronous operations
    Completer<User?> completer = Completer<User?>();

    _auth.authStateChanges().listen((User? user){
      if (user != null){
        completer.complete(user);
      }else{
        print('User is signed out!');
        completer.complete(null);
      }

    });
    // return the future from the completer
    return completer.future;
    
  }
}