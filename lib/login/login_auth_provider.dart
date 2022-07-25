import 'package:cafemilanoadmin/admin/admin.dart';
import 'package:cafemilanoadmin/homepage.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(LoginAuthProvider.pattern.toString());

  bool loading = false;

  UserCredential? userCredential;

  void loginPageVaidation(
      {required TextEditingController? email,
      required TextEditingController? password,
      required BuildContext context}) async {
    if (email!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email address is empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be 8"),
        ),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then(
          (value) async {
            loading = false;
            notifyListeners();
              var firebaseuser = await FirebaseAuth.instance.currentUser;
              final snapshot = await FirebaseFirestore.instance.collection("userdata").doc(firebaseuser!.uid).get();
              if(snapshot.exists){
                var userField = snapshot.data();
                if(userField!["role"]=="admin"){
                  RoutingPage.goTonext(context: context, navigateTo: admin());
                }else if(userField["role"]=="user"){
                  RoutingPage.goTonext(context: context, navigateTo: homepage());
                }
              }else{
                RoutingPage.goTonext(context: context, navigateTo: LoginPage());
              }
          },
        );
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("user-not-found"),
            ),
          );
        } else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("wrong-password"),
            ),
          );
        }
      }
    }
  }
}
