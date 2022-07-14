import 'package:flutter/material.dart';

class singleproducts extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  const singleproducts({
    Key? key,
  required this.image,
    required this.name,
    required this.price,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 200,
          width: 175,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\₹$price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}