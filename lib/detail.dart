import 'package:flutter/material.dart';
class detailpage extends StatelessWidget {
  final String productimage;
  final String productname;
  final String productdescription;
  final int productprice;
  final int productoldprice;

  detailpage({
    Key? key,
    required this.productimage,
    required this.productname,
    required this.productprice,
    required this.productoldprice,
    required this.productdescription,
  }) : super(key: key);
  Size? size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productimage)
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4+60,
                decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: Offset(0, -4),
                          blurRadius: 8
                      )
                    ]
                ),
                child: Padding( padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productname,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.favorite_border_rounded,color: Colors.brown[900],))
                        ],
                      ),
                      Column(
                        children: [
                          Divider(thickness:3,color: Colors.black,),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                '\₹$productprice',
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(width: 25,),
                              Text(
                                '\₹$productoldprice',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.amber[300],
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness:3,color: Colors.black),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            productdescription,
                            style: TextStyle(
                              color: Colors.brown[900],
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),

                      MaterialButton(
                        onPressed:(){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(productname+" Added To Cart"),
                              ),
                          );

                        },
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              'Add to Cart',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
