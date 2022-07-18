import 'package:cafemilanoadmin/admin/dashboard.dart';
import 'package:cafemilanoadmin/admin/manage.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin extends StatelessWidget {
  admin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple[600],
        title: Text(
          'ADMIN HOME',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  })));
            },
            icon: Icon(Icons.exit_to_app_sharp,color: Colors.white),
          ),
        ],
        leading: Icon(Icons.admin_panel_settings_sharp,color: Colors.white),
      ),
    );
  }
}
