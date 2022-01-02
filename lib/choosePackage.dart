import 'package:feast_app/packageBuy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';

class choosePackage extends StatefulWidget {

  String storeID;
  choosePackage({Key key, this.storeID}) : super(key:key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<choosePackage> {

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ///initializari screen sizes
    Size _screenSize = MediaQuery.of(context).size;
    double _screenTopPadding = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: _screenTopPadding < 30.0
            ? EdgeInsets.fromLTRB(00.0, 40.0, 0.0, 0.0) //Fara notch
            : EdgeInsets.fromLTRB(00.0, 30.0, 0.0, 0.0), //Cu notch // astea noi oricare si cu notch si fara
        /// dupa ? e fara notch si dupa : e cu notch
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:20,bottom: 10, left:20,right: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed:(){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text("Choose package", style: TextStyle(fontSize: 26, color: Color(0xffff682c), fontWeight: FontWeight.w500,),),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: FutureBuilder(
                            future: FirebaseFirestore.instance.collection("Shops/${widget.storeID}/Packages").get(),
                            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                              if(snapshot.hasData){
                                print(snapshot.data.docs.length);
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return GestureDetector(
                                        onTap: (){
                                          print(snapshot.data.docs[index].id);
                                          if(snapshot.data.docs[index].data()["Stock"]>0)
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => packageBuy(storeID:widget.storeID ,packageID: snapshot.data.docs[index].id),
                                                ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top:10, left:20, right:20, bottom: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                // foregroundDecoration: BoxDecoration(
                                                //   gradient: LinearGradient(
                                                //     colors: [Colors.transparent, Colors.black],
                                                //     begin: Alignment.topCenter,
                                                //     end: Alignment.bottomCenter,
                                                //     stops: [0.6, 1],
                                                //   ),
                                                // ),
                                                height:200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      snapshot.data.docs[index].data()["Background"],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  child: Row(
                                                    children: [
                                                      Text(snapshot.data.docs[index].data()["Size"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                                      Text(", Price: ${snapshot.data.docs[index].data()["Price"]} Lei", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                                      Expanded(
                                                        child: Container(
                                                            alignment: Alignment.centerRight,
                                                            child: Icon(Icons.arrow_forward_ios)
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(top:5),
                                                child: Text("Stock: ${snapshot.data.docs[index].data()["Stock"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }else return Container();

                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );

  }
}

// class Explore extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _State();
// }
//
// class _State extends State<Explore> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }