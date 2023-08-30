import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vpn_prog/screens/addproduct.dart';
import 'package:vpn_prog/screens/deleteproduct.dart';
import 'package:vpn_prog/screens/update.dart';
import 'package:vpn_prog/screens/viewproduct.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore CRUD',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
              },
              child: Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProductsScreen()));
              },
              child: Text('Read Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateScreen()));
              },
              child: Text('Update Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeleteScreen()));
              },
              child: Text('Delete Product'),
            ),
          ],
        ),
      ),
    );
  }
}
