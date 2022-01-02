import 'package:feast_app/explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';

class packageBuy extends StatefulWidget {

  String storeID, packageID;
  packageBuy({Key key, this.storeID, this.packageID}) : super(key:key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<packageBuy> {

  int selectedRadioTile;

  initState() {
    selectedRadioTile = 0;
    super.initState();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUserId() {
    final User user = auth.currentUser;
    final uid = user.uid;
    print(uid);
    return(uid);
    // here you write the codes to input the data into firestore
  }

  String address;

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
                  Text("Finish order", style: TextStyle(fontSize: 26, color: Color(0xffff682c), fontWeight: FontWeight.w500,),),
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
                          margin: EdgeInsets.only(top:20, left:20,right: 20),
                          alignment: Alignment.centerLeft,
                          child: Text("Order summary", style: TextStyle(fontSize: 22, color: Color(0xff636363), fontWeight: FontWeight.w500,),),
                        ),

                        Container(
                          margin: EdgeInsets.only(top:10, left:20,right: 20),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              children: [
                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('Shops')
                                      .doc(widget.storeID)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                      snapshot) {
                                    return snapshot.hasData
                                        ? Container(
                                          margin: EdgeInsets.only(top:20, left:10, right:10, bottom:10),
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(snapshot.data["Name"], style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500,),),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(snapshot.data["Address"], style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,),),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                        : Container();
                                  },
                                ),

                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('Shops/${widget.storeID}/Packages')
                                      .doc(widget.packageID)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                      snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data["Content"].length,
                                      itemBuilder: (BuildContext context, int index){
                                        return Container(
                                          margin: EdgeInsets.only(left:10, right:10, bottom: 10),
                                          child: Text("- ${snapshot.data["Content"][index]}", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,),),
                                        );
                                      },
                                    )
                                        : Container();
                                    },
                                ),

                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('Shops/${widget.storeID}/Packages')
                                      .doc(widget.packageID)
                                      .get(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                      snapshot) {
                                    return snapshot.hasData
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(top:10, left:10, right:10, bottom: 10),
                                            child: Text("Total: ${snapshot.data["Price"]} Lei", style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500,),),
                                    )
                                        : Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top:20, left:20,right: 20, bottom: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Delivery Options", style: TextStyle(fontSize: 22, color: Color(0xff636363), fontWeight: FontWeight.w500,),),
                        ),

                        Container(
                          margin: EdgeInsets.only(left:20, right:20),
                          child: Card(
                            elevation: 2,
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadioTile,
                              title: Text("Pick up in store", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              ),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                setSelectedRadioTile(val);
                              },
                              activeColor: Color(0xffff682c),

                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left:20, right:20),
                          child: Card(
                            elevation: 2,
                            child: RadioListTile(
                              value: 2,
                              groupValue: selectedRadioTile,
                              title: Text("Deliver to me", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              ),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                setSelectedRadioTile(val);
                              },
                              activeColor: Color(0xffff682c),

                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top:20, left:20,right: 20),
                          child: Row(
                            children: [
                              Container(
                                  child: Text("Shipping address", style: TextStyle(fontSize: 22, color: Color(0xff636363), fontWeight: FontWeight.w500,),)
                              ),
                            ],
                          ),
                        ),

                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(getUserId().toString())
                              .get(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot>
                              snapshot) {

                            if(snapshot.hasData){

                            address = snapshot.data["Address"];

                            return Container(
                                    margin: EdgeInsets.only(top:10, left:20, right:20, bottom:10),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right:5),
                                              child: Icon(Icons.house_rounded,size: 35,color: Color(0xffff682c),),
                                            ),
                                            Flexible(child: Text(snapshot.data["Address"], style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500,),)),
                                          ],
                                        ),
                                    ),
                            );}
                            else return Container();
                          },
                        ),

                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 20),
                            height: 60,
                            width: 210,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffff682c),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed:()async{
                                await FirebaseFirestore.instance
                                    .collection('Orders').doc()
                                    .set({
                                  'ShopID': widget.storeID,
                                  'PackageID': widget.packageID,
                                  'UserID': getUserId().toString(),
                                  'Delivery': selectedRadioTile == 0 ? "InStore" : "Deliver",
                                });

                                await FirebaseFirestore.instance
                                    .collection('Shops/${widget.storeID}/Packages').doc(widget.packageID)
                                    .update({
                                  'Stock':FieldValue.increment(-1)
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Explore(),
                                    ));

                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmation'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Your order has been confirmed!'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Confirm order",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        )

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