import 'package:cafemilanoadmin/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin extends StatelessWidget {
  admin({Key? key}) : super(key: key);
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
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
      body:Stack(
        children: [
          Row(children: [
            Expanded(child: Container(
              height: 55,
              child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    setState(() => _selectedPage = Page.dashboard);
                  },
                child: Row(children: [
                  Icon(Icons.dashboard, color: _selectedPage == Page.dashboard
                      ? active
                      : notActive,),
                  SizedBox(width: 18),
                  Text(
                      'DASHBOARD',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1
                    ),
                  )
                ],)
              ),
            )),
            Expanded(child: Container(
              height: 55,
              child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    setState(() => _selectedPage = Page.dashboard);
                  },
                  child: Row(children: [
                    Icon(Icons.settings, color: _selectedPage == Page.dashboard
                        ? active
                        : notActive,),
                    SizedBox(width: 18),
                    Text(
                      'MANAGE',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1
                      ),
                    )
                  ],)
              ),
            )),
          ],)
        ],
      ),
    );
  }
}
