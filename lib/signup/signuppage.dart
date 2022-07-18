import 'package:cafemilanoadmin/login/button.dart';
import 'package:cafemilanoadmin/login/login.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signuppage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(signuppage.pattern.toString());
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();
  Future sendData() async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(userCredential.user?.uid)
          .set({
        'fullname': fullname.text.trim(),
        'email': email.text.trim(),
        'userid': userCredential.user?.uid,
        'password': password.text.trim(),
        'image': ''.toString(),
      }).then((value) => RoutingPage.goTonext(
                context: context,
                navigateTo: LoginPage(),
              ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The Password Provided Is Weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account Already Exist For That Email"),
          ),
        );
      }
    } catch (e) {
      globalKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void validation() {
    if (fullname.text.trim().isEmpty || fullname.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Full Name Is Empty"),
        ),
      );
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Address Is Empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Enter Valid Email"),
        ),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is Empty"),
        ),
      );
      return;
    }
    if (password.text != repassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Should be Match"),
        ),
      );
      return;
    } else {
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  Widget Textfield(
      {required String hinttext,
      required IconData icon,
      required Color? iconColor,
      required TextEditingController controller}) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.brown[900]),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.brown.shade900,
                  strokeAlign: StrokeAlign.center,
                  width: 1),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(
          'SIGN UP',
          style: TextStyle(
              color: Colors.brown[900],
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: Colors.brown[900],
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('asset/burger.png'),
                        maxRadius: 90,
                      ),
                    ),
                  ),
                )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 480,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Textfield(
                                    hinttext: 'Full Name',
                                    icon: Icons.person_outline,
                                    iconColor: Colors.brown[900],
                                    controller: fullname),
                                Textfield(
                                    hinttext: 'Email',
                                    icon: Icons.email_outlined,
                                    iconColor: Colors.brown[900],
                                    controller: email),
                                Textfield(
                                    hinttext: 'Password',
                                    icon: Icons.lock_outline,
                                    iconColor: Colors.brown[900],
                                    controller: password),
                                Textfield(
                                    hinttext: 'Re-enter Password',
                                    icon: Icons.lock_reset_outlined,
                                    iconColor: Colors.brown[900],
                                    controller: repassword),
                                MyButton(
                                    onPressed: () {
                                      validation();
                                    },
                                    text: 'SIGN UP'),
                                loading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Already Have An Account?',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginPage();
                                                }));
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ))
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
