import 'package:cafemilanoadmin/homepage.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class profile extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(profile.pattern.toString());
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool isedit = false;
  TextEditingController fullname =
      TextEditingController(text: usermodelobj.fullname);
  TextEditingController email = TextEditingController(text: usermodelobj.email);
  File? pickedImage;
  File? imageFile;
  bool showlocalimage = false;
  Widget TextField(
      {required String hinttext,
      required IconData icon,
      required bool enable,
      required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          enabled: enable,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              icon,
              color: Colors.brown[900],
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
      ),
    );
  }

  Widget edittextfirld() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border.all(color: Colors.amber.shade700, width: 5),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: showlocalimage == false
                      ? NetworkImage(usermodelobj.image == ''
                          ? 'https://th.bing.com/th/id/OIP.MclojOSIH_8-uyHTM3WdZQHaH5?w=165&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
                          : usermodelobj.image)
                      : FileImage(pickedImage!) as ImageProvider,
                )),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon:
                          Icon(Icons.person, color: Colors.brown.shade900),
                      hintText: 'fullname',
                      hintStyle: TextStyle(color: Colors.brown[900]),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown.shade900,
                              strokeAlign: StrokeAlign.center,
                              width: 1),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon:
                          Icon(Icons.mail, color: Colors.brown.shade900),
                      hintText: 'email',
                      hintStyle: TextStyle(color: Colors.brown[900]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.brown.shade900,
                            strokeAlign: StrokeAlign.center,
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    profileVaidation(
                      context: context,
                      email: email,
                      fullname: fullname,
                    );
                  },
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'UPDATE PROFILE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Camera'),
                                  onTap: () {
                                    pickimagefromdevice(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.storage_sharp),
                                  title: const Text('Gallery'),
                                  onTap: () {
                                    pickimagefromdevice(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void profileVaidation(
      {required TextEditingController? email,
      required TextEditingController? fullname,
      required BuildContext context}) async {
    if (fullname!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fullName is empty"),
        ),
      );
      return;
    } else if (email!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email address is empty"),
        ),
      );
      return;
    } else if (!widget.regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else {
      buildUpdateProfile();
    }
  }

  Future buildUpdateProfile() async {
    FirebaseFirestore.instance
        .collection("userdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "fullname": fullname.text,
        "email": email.text,
      },
    ).then(
      (value) => RoutingPage.goTonext(context: context, navigateTo: homepage()),
    );
  }

  pickimagefromdevice(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file == null) return;

    pickedImage = File(file.path);
    showlocalimage = true;
    setState(() {});
    try {
      var fileName = usermodelobj.email + '.jpg';

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName)
          .putFile(pickedImage!);

      TaskSnapshot snapshot = await uploadTask;
      String profileImageUrl = await snapshot.ref.getDownloadURL();
      print(profileImageUrl);

      var uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(uid)
          .update({"image": profileImageUrl});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile Picture Updated Successfully...!!!"),
          ),);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,),
              ),
        title: Text(
          'PROFILE DETAILS',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isedit = true;
                });
              },
              icon: Icon(Icons.edit,color: Colors.white,))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer()),
          edittextfirld()
        ],
      ),
    );
  }
}

class ProgressDialog {}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.amber.shade200;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
