import 'package:cafemilanoadmin/homepage.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(profile.pattern.toString());
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool isedit = false;
  TextEditingController fullname =TextEditingController(text: usermodelobj.fullname);
  TextEditingController email =TextEditingController(text: usermodelobj.email);

  Widget TextField({required String hinttext,required IconData icon,required bool enable,required TextEditingController controller}){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          enabled: enable,
          decoration: InputDecoration(filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon,color:Colors.brown[900],),
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.brown[900]),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown.shade900,strokeAlign: StrokeAlign.center,width:1),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
      ),
    );
  }
  Widget nonedittextfield(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.amber.shade200,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.amber.shade700,width: 5),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:NetworkImage(usermodelobj.image)
              )
          ),
        ),
        SizedBox(height: 15,),
        TextField(hinttext: usermodelobj.fullname, icon:Icons.person,enable: false,controller: fullname),
        TextField(hinttext: usermodelobj.email, icon:Icons.email,enable: false,controller: email),
      ],
    );

  }
  Widget edittextfirld(){
    return SingleChildScrollView(scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border.all(color: Colors.amber.shade700,width: 5),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(usermodelobj.image)
                )
            ),
          ),
          Container(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person,color:Colors.brown.shade900),
                      hintText:'fullname',
                      hintStyle: TextStyle(color: Colors.brown[900]),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown.shade900,strokeAlign: StrokeAlign.center,width:1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.mail,color:Colors.brown.shade900),
                      hintText:'email',
                      hintStyle: TextStyle(color: Colors.brown[900]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown.shade900,strokeAlign: StrokeAlign.center,width:1),
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
                      child: Text('UPDATE PROFILE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )


              ],
            ),


          ),

        ],
      ),
    );
  }
  void profileVaidation({required TextEditingController? email, required TextEditingController? fullname, required BuildContext context}) async {
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
          (value) => RoutingPage.goTonext(
          context: context,
          navigateTo:homepage()
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: isedit?IconButton(
            onPressed: (){
              setState((){
                isedit=false;
              });
            },
            icon: Icon(Icons.close))
            :IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

        title: Text(
          'PROFILE DETAILS',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing:1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                setState((){
                  isedit=true;

                });
              },
              icon: Icon(Icons.edit))
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
              painter: HeaderCurvedContainer()
          ),

          isedit? edittextfirld() : nonedittextfield(),
        ],
      ),
    );
  }
}

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
