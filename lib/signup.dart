import 'package:feast_app/choosePackage.dart';
import 'package:feast_app/explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:async';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Signup> {

  initState() {
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUserId() {
    final User user = auth.currentUser;
    final uid = user.uid;
    print(uid);
    return(uid);
    // here you write the codes to input the data into firestore
  }

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController SurnameController = TextEditingController();
  TextEditingController AddressController = TextEditingController();

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
                  Text("Sign up", style: TextStyle(fontSize: 26, color: Color(0xffff682c), fontWeight: FontWeight.w500,),),
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
                          margin: EdgeInsets.only(top:20,left: 40, right: 40),
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black12,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black54),
                              cursorColor: Colors.grey,
                              controller: NameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                hintText: 'Name',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,left: 40, right: 40),
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black12,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black54),
                              cursorColor: Colors.grey,
                              controller: SurnameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                hintText: 'Surname',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,left: 40, right: 40),
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black12,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black54),
                              cursorColor: Colors.grey,
                              controller: EmailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,left: 40, right: 40),
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black12,
                            ),
                            child: TextField(
                              obscureText: true,
                              style: TextStyle(color: Colors.black54),
                              cursorColor: Colors.grey,
                              controller: PasswordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10,left: 40, right: 40),
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.black12,
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.black54),
                              cursorColor: Colors.grey,
                              controller: AddressController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.black12, width: 2.0),
                                ),
                                hintText: 'Address',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            height: 50,
                            width: 190,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffff682c),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed:()async{
                                try {
                                  UserCredential userCredential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                      email: EmailController.text,
                                      password: PasswordController.text);

                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(userCredential.user.uid)
                                      .set({
                                    'Name': NameController.text,
                                    'Surname': SurnameController.text,
                                    'Email': EmailController.text,
                                    'Address': AddressController.text,

                                  });


                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Explore(),
                                      ));

                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'The password provided is too weak.'),
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
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'The account already exists for that email.'),
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
                                    print('The account already exists for that email.');
                                  } else if (e.code == 'invalid-email') {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Please enter a valid email address.'),
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
                                    print('The account already exists for that email.');
                                  }
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 22),
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