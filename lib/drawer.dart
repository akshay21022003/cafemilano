import 'package:cafemilanoadmin/cart.dart';
import 'package:cafemilanoadmin/homepage.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:cafemilanoadmin/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildDrawar extends StatelessWidget {
  const BuildDrawar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amber.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            accountName: Text(
              usermodelobj.fullname,
              style: TextStyle(
                  color: Colors.brown[900], fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              usermodelobj.email,
              style: TextStyle(
                  color: Colors.brown[900], fontWeight: FontWeight.normal),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.amber.shade900,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey[900],
                backgroundImage: NetworkImage(usermodelobj.image == ''
                    ? 'https://th.bing.com/th/id/OIP.MclojOSIH_8-uyHTM3WdZQHaH5?w=165&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
                    : usermodelobj.image),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return profile();
              }));
            },
            child: ListTile(
              leading: IconButton(
                color: Colors.brown.shade900,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return profile();
                  }));
                },
                icon: Icon(
                  Icons.person,
                ),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return cart();
              }));
            },
            child: ListTile(
              leading: IconButton(
                color: Colors.brown.shade900,
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                ),
              ),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: ListTile(
              leading: IconButton(
                color: Colors.brown.shade900,
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                ),
              ),
              title: Text(
                'Favorite',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: ListTile(
              leading: IconButton(
                color: Colors.brown.shade900,
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_basket,
                ),
              ),
              title: Text(
                'My Order',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              })));
            },
            child: ListTile(
              leading: IconButton(
                color: Colors.amber[900],
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      })));
                },
                icon: Icon(
                  Icons.exit_to_app_sharp,
                ),
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.brown.shade900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
