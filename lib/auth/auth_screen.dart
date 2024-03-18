import 'package:flutter/material.dart';
import 'package:instagram_app_clone/screen/login_screen.dart';
import 'package:instagram_app_clone/screen/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthScreen> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  } 

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginScreen(go);
    } else {
      return SignupScreen(go);
    }
  }
}
