import 'package:flutter/material.dart';
class usertemplate extends StatelessWidget {
  final String fullname;
  final String email;
  final String image;
   usertemplate({
    Key? key,
     required this.fullname,
     required this.email,
     required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 130,
        width: 400,
        decoration: BoxDecoration(
          border: Border.all(width: 2,color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height:100,
                    width:100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit:BoxFit.cover,
                            image: NetworkImage(
                            image == ''
                                ? 'https://th.bing.com/th/id/OIP.MclojOSIH_8-uyHTM3WdZQHaH5?w=165&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
                                : image
                        ))
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top:10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fullname,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                  Text(email,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
