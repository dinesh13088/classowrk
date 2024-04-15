import 'package:classwork/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKeyy = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isChecked = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void checkIfUserIsLoggedIn(BuildContext context) async {
    // Obtain shared preferences.
    final user = await FirebaseAuthService().getLoggedInUser();
    if (user != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uId', user.uid);
      Navigator.of(context).pushNamed('/myapp');
    }
  }

  // function to handle login onPressed
  handleLogin(BuildContext context) async {
    if (isChecked != null) {
      if (isChecked.value) {
        final username = usernameController.text;
        final password = passwordController.text;
        final firebaseAuth = FirebaseAuthService();
        final User? user = await firebaseAuth.loginWithEmailPassword(username, password);
        if (user != null) {
          print('login success');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uId', user.uid);
          Navigator.of(context).pushReplacementNamed('/myapp');
        } else {
          print('Login error');
        }
      } else {
        print('Please check the terms');
      }
    }
  }
}
