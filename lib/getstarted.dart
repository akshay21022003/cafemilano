import 'package:cafemilanoadmin/login/button.dart';
import 'package:flutter/material.dart';
import 'package:cafemilanoadmin/login/login.dart';
class getstarted extends StatefulWidget {
  @override
  State<getstarted> createState() => _getstartedState();
}

class _getstartedState extends State<getstarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Image.asset('asset/burger.jpg'),
              )),
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'WELCOME TO CAFÉ MILANO',
                      style: TextStyle(
                        fontSize: 29,fontWeight: FontWeight.bold,color: Colors.brown[900],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'order food from our restaurent and',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown
                          ),
                        ),
                        Text(
                          'make reservation in real time',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown
                          ),
                        ),
                      ],
                    ),
                    MyButton(onPressed: (){}, text: 'Get Started')

                  ],
                ),

              )),
        ],
      ),

    );
  }
}
