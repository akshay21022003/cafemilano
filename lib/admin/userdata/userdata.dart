import 'package:cafemilanoadmin/admin/userdata/usertemplate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userdata extends StatelessWidget {
  Size? size;
  userdata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.verified_user_rounded,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'USERDATA',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height,
              /*Stream builder build itself based on latest snapshot present in our firebase
            e.g. if we add some category inside our database then
            it directly reflect on our category section*/
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("userdata")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          return usertemplate(
                              fullname: streamSnapshot.data!.docs[index]["fullname"],
                              email: streamSnapshot.data!.docs[index]["email"],
                              image: streamSnapshot.data!.docs[index]["image"],
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// singleproducts(
// onTap: (){
// RoutingPage.goTonext(context: context, navigateTo: detailpage(
// productdescription:streamSnapshot.data!.docs[index]
// ["productdescription"],
// productimage: streamSnapshot.data!.docs[index]
// ["productimage"],
// productname: streamSnapshot.data!.docs[index]
// ["productname"],
// productprice: streamSnapshot.data!.docs[index]
// ["productprice"],
// productoldprice: streamSnapshot.data!.docs[index]
// ["productoldprice"],
//
// ));
// },
// image: streamSnapshot.data!.docs[index]
// ["productimage"],
// name: streamSnapshot.data!.docs[index]
// ["productname"],
// price: streamSnapshot.data!.docs[index]
// ["productprice"]);
