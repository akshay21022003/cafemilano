import 'package:cafemilanoadmin/detail.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cafemilanoadmin/singleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class productview extends StatelessWidget {
  final String id;
  final String collection;
  final String product;

  const productview({
    Key? key,
    required this.id,
    required this.collection,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[600],
        elevation: 0,
        centerTitle: true,
        title: Text(
          product+"'s",
          style: TextStyle(
            color: Colors.brown.shade900,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("categories")
              .doc(id)
              .collection(collection)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.brown[500],
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.brown[900],
                          ),
                          fillColor: Colors.amber.shade100,
                          hintText: 'Search Your Food',
                          hintStyle: TextStyle(
                              color: Colors.brown[900],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.brown.shade900,
                                  strokeAlign: StrokeAlign.center,
                                  width: 10),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.4,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return singleproducts(
                      onTap: (){
                       RoutingPage.goTonext(context: context, navigateTo:detailpage(
                         productdescription:snapshot.data!.docs[index]
                         ["productdescription"],
                         productimage: snapshot.data!.docs[index]
                         ["productimage"],
                         productname: snapshot.data!.docs[index]
                         ["productname"],
                         productprice: snapshot.data!.docs[index]
                         ["productprice"],
                         productoldprice: snapshot.data!.docs[index]
                         ["productoldprice"],
                       ));
                      },
                        image: data["productimage"],
                        name: data["productname"],
                        price: data["productprice"]); //singleproducts();
                  },
                ),
              ],
            );
          }),
      /*Column(
        children: [
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.all(10),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.brown[500],
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.brown[900],),
                    fillColor: Colors.white,
                    hintText: 'Search Your Food',
                    hintStyle: TextStyle(color: Colors.brown[900]),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
            ),
          ),

        ],
      ),*/
    );
  }
}
