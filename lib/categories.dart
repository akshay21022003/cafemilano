import 'package:flutter/material.dart';

class categories extends StatelessWidget {
  final String image;
  final String categoryname;
  final Function()? ontap;
  const categories({
    Key? key,
    required this.image,
    required this.categoryname,
    required this.ontap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.all(10),
          height: 100,
          width: 175,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.2)),
            child: Center(
              child: Text(
                categoryname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          )),
    );
  }
}
