import 'package:cafemilanoadmin/singleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class productview extends StatelessWidget {
  final String id;
  final String collection;

  const productview({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[900],
        elevation: 0,
        centerTitle: true,
          title: Text(
            'FOOD PRODUCTS',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing:1,
            ),
          ),
      ),
      body: FutureBuilder(
          future:FirebaseFirestore.instance.collection("categories").doc(id).collection(collection).get(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                SizedBox(height: 10),
                Padding(padding: EdgeInsets.all(10),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.brown[500],
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search,color: Colors.brown[900],),
                          fillColor: Colors.brown.shade200,
                          hintText: 'Search Your Food',
                          hintStyle: TextStyle(color: Colors.brown[900],fontWeight: FontWeight.w500,letterSpacing: 1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown.shade900,strokeAlign: StrokeAlign.center,width: 10),
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount:snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.4,
                        crossAxisCount:2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20),
                    itemBuilder: (context,index){
                    var data = snapshot.data!.docs[index];
                      return singleproducts(image: data["productimage"], name:data["productname"], price:data["productprice"]);//singleproducts();
                    },
                ),
              ],
            );
          }
      ),
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
