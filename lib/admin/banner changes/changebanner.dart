import 'package:cafemilanoadmin/admin/banner%20changes/banner.dart';
import 'package:cafemilanoadmin/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class banneradmin extends StatefulWidget {
  const banneradmin({Key? key}) : super(key: key);
  @override
  State<banneradmin> createState() => _banneradminState();
}

class _banneradminState extends State<banneradmin> {
  File? pickedImage;
  File? imageFile;
  bool showlocalimage = false;
  pickimagefromdevice(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: source);
    if (file == null) return;

    pickedImage = File(file.path);
    showlocalimage = true;
    setState(() {});
    try {
      var fileName = usermodelobj.email+'.jpg';

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('banner')
          .child(fileName)
          .putFile(pickedImage!);

      TaskSnapshot snapshot = await uploadTask;
      String profileImageUrl = await snapshot.ref.getDownloadURL();
      print(profileImageUrl);

      await FirebaseFirestore.instance
          .collection('banner')
          .doc("7Nt1T6UaaAHUiPUn9v31")
          .update({"image": profileImageUrl});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Banner Updated Successfully...!!!"),
        ),);
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.photo_library,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'BANNER EDIT',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 250,
              /*Stream builder build itself based on latest snapshot present in our firebase
              e.g. if we add some category inside our database then
              it directly reflect on our category section*/
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("banner")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          return banner(image: streamSnapshot.data!.docs[index]
                          ["image"]);
                        });
                  }),
            ),
          ),
    MaterialButton(
      onPressed: (){
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
      height: 50,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
      padding: EdgeInsets.all(25),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text('UPDATE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),

        ],
      ),
    );
  }
}
