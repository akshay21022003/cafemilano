import 'package:flutter/material.dart';

class ruf extends StatelessWidget {
  const ruf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body:
          Padding(
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
                              color: Colors.red
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
                          Text('akshay ashok vilawadekar',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1
                            ),
                          ),
                          Text('akshayvilawadekar21@gmail.com',
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
          ),
    );
  }
}
