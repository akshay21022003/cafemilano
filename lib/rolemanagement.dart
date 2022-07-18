import 'package:cafemilanoadmin/homepage.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class rolemanagement {
  Widget handleauth() {
    return new StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnp) {
        if (userSnp.hasData) {
          return homepage();
        }
        return LoginPage();
      },
    );
  }
}
