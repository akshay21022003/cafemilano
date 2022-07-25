import 'package:flutter/material.dart';
class banner extends StatelessWidget {
  final String image;
   banner({
    Key? key,
    required this.image,
  }) : super(key: key);
 Size? size;
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image == ''
                      ? 'https://th.bing.com/th/id/OIP.MclojOSIH_8-uyHTM3WdZQHaH5?w=165&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
                      : image))),
        );
  }
}
