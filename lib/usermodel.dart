import 'package:cloud_firestore/cloud_firestore.dart';

class usermodel {
  final String fullname;
  final String email;
  final String password;
  final String userid;
  final String image;
  usermodel({
    required this.fullname,
    required this.email,
    required this.password,
    required this.userid,
    required this.image,
  });
  factory usermodel.fromDocument(DocumentSnapshot doc) {
    return usermodel(
      fullname: doc['fullname'],
      email: doc['email'],
      password: doc['password'],
      userid: doc['userid'],
      image: doc['image'],
    );
  }
}
