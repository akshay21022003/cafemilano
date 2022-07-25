import 'package:cafemilanoadmin/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin extends StatelessWidget {
  const admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.amber[600],
        title: Text(
            'ADMIN PANEL',
          style: TextStyle(
            color: Colors.brown[900],
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut().then(
                      (value) =>Navigator.push(context,MaterialPageRoute(builder: (context){return LoginPage();})));
            },
            icon: Icon(Icons.exit_to_app_sharp),
          ),
        ],
      ),
    );
  }
}
