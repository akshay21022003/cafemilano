import 'package:cafemilanoadmin/admin/banner%20changes/changebanner.dart';
import 'package:cafemilanoadmin/admin/dashboard.dart';
import 'package:cafemilanoadmin/admin/manage.dart';
import 'package:cafemilanoadmin/admin/userdata/userdata.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin extends StatelessWidget {
  admin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple[600],
        title: Text(
          'ADMIN PANEL',
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
      body: Column(
        children: [
          MaterialButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return userdata();
                      }));
            },
            height:75 ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(25),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child:Container(
                  height: 75,
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.person,color: Colors.white,),
                      SizedBox(width: 65,),
                      Text('USERDATA',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  )
              ),
            ),
          ),
        MaterialButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) {
                    return banneradmin();
                  }));
        },
        height:75 ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(25),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child:Container(
              height: 75,
              alignment: Alignment.center,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:10,),
                  Icon(Icons.photo_library,color: Colors.white,),
                  SizedBox(width: 65,),
                  Text('BANNER',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width:10,),
                ],
              )
            ),
        ),
      ),
        ],
      ),
    );
  }
}
