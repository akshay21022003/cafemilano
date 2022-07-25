import 'package:cafemilanoadmin/admin/banner%20changes/banner.dart';
import 'package:cafemilanoadmin/cart.dart';
import 'package:cafemilanoadmin/categories.dart';
import 'package:cafemilanoadmin/detail.dart';
import 'package:cafemilanoadmin/drawer.dart';
import 'package:cafemilanoadmin/productview.dart';
import 'package:cafemilanoadmin/routing_page.dart';
import 'package:cafemilanoadmin/singleproduct.dart';
import 'package:cafemilanoadmin/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late usermodel usermodelobj;
class homepage extends StatefulWidget {
  const homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Future getcurrentuserdata() async {
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          usermodelobj = usermodel.fromDocument(documentSnapshot);
        } else {
          print('document does not exist the database');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getcurrentuserdata();
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      drawer: BuildDrawar(),
      appBar: AppBar(
        title: Text(
          'CAFÉ MILANO',
          style: TextStyle(
              color: Colors.brown[900],
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
        actions: [
          IconButton(onPressed: (){
            RoutingPage.goTonext(context: context, navigateTo: cart(),);
          }, icon: Icon(Icons.shopping_cart_checkout_rounded,color: Colors.brown[900],))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      //using listview to avoid overflowing of the screen
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
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
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 150,
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
          SizedBox(height: 5,),
          ListTile(
            leading: Text(
              'Categories',
              style: TextStyle(
                color: Colors.brown[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            height: 100,
            /*Stream builder build itself based on latest snapshot present in our firebase
            e.g. if we add some category inside our database then
            it directly reflect on our category section*/
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("categories")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        return categories(
                          categoryname: streamSnapshot.data!.docs[index]
                              ["categoryname"],
                          image: streamSnapshot.data!.docs[index]
                              ["categoryimage"],
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => productview(
                                  product: streamSnapshot.data!.docs[index]
                                  ["categoryname"],
                                      id: streamSnapshot.data!.docs[index].id,
                                      collection: streamSnapshot
                                          .data!.docs[index]["categoryname"],
                                    )));
                            /*RoutingPage.goTonext(context: context, navigateTo: productview(
                                collection: streamSnapshot.data!.docs[index]["categoryname"],
                                id:streamSnapshot.data!.docs[index].id,
                              ));*/
                          },
                        );
                      });
                }),
          ),
          ListTile(
            leading: Text(
              "Today's Deal",
              style: TextStyle(
                color: Colors.brown[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            height: 280,
            /*Stream builder build itself based on latest snapshot present in our firebase
            e.g. if we add some category inside our database then
            it directly reflect on our category section*/
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("todaysdeal")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        return singleproducts(
                          onTap: (){
                            RoutingPage.goTonext(context: context, navigateTo: detailpage(
                              productdescription:streamSnapshot.data!.docs[index]
                              ["productdescription"],
                              productimage: streamSnapshot.data!.docs[index]
                              ["productimage"],
                              productname: streamSnapshot.data!.docs[index]
                              ["productname"],
                              productprice: streamSnapshot.data!.docs[index]
                              ["productprice"],
                              productoldprice: streamSnapshot.data!.docs[index]
                              ["productoldprice"],

                            ));
                          },
                            image: streamSnapshot.data!.docs[index]
                                ["productimage"],
                            name: streamSnapshot.data!.docs[index]
                                ["productname"],
                            price: streamSnapshot.data!.docs[index]
                                ["productprice"]);
                      });
                }),
          ),
          ListTile(
            leading: Text(
              'Customers Favorite',
              style: TextStyle(
                color: Colors.brown[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            height: 280,
            /*Stream builder build itself based on latest snapshot present in our firebase
            e.g. if we add some category inside our database then
            it directly reflect on our category section*/
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("product")
                    .where("productrate", isGreaterThan: 3)
                    .orderBy("productrate", descending: true)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        return singleproducts(
                          onTap: (){
                            RoutingPage.goTonext(context: context, navigateTo: detailpage(
                              productdescription:streamSnapshot.data!.docs[index]
                              ["productdescription"],
                              productimage: streamSnapshot.data!.docs[index]
                              ["productimage"],
                              productname: streamSnapshot.data!.docs[index]
                              ["productname"],
                              productprice: streamSnapshot.data!.docs[index]
                              ["productprice"],
                              productoldprice: streamSnapshot.data!.docs[index]
                              ["productoldprice"],
                            ),);
                          },
                            image: streamSnapshot.data!.docs[index]
                                ["productimage"],
                            name: streamSnapshot.data!.docs[index]
                                ["productname"],
                            price: streamSnapshot.data!.docs[index]
                                ["productprice"]);
                      });
                }),
          ),
        ],
      ),
    );
  }
}
