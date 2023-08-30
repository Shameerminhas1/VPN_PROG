import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateScreen extends StatelessWidget {
  Future<void> updateItem(DocumentSnapshot document, String newName,
      String newDescription, double newPrice) async {
    final docRef =
        FirebaseFirestore.instance.collection('products').doc(document.id);
    await docRef.update({
      'name': newName,
      'description': newDescription,
      'price': newPrice,
    });
  }

  Future<void> _showUpdateDialog(
      BuildContext context, DocumentSnapshot product) async {
    String updatedName = ''; // Store the updated name here
    String updatedDescription = ''; // Store the updated description here
    double updatedPrice = 0.0; // Store the updated price here

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  updatedName = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter updated name',
                ),
              ),
              TextField(
                onChanged: (value) {
                  updatedDescription = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter updated description',
                ),
              ),
              TextField(
                onChanged: (value) {
                  updatedPrice = double.parse(value);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Enter updated price',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateItem(product, updatedName, updatedDescription,
                    updatedPrice); // Update the item
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productName = product['name'];
              final productPrice = product['price'];
              return Container(
                margin: EdgeInsets.all(5),
                color: Colors.amber,
                child: ListTile(
                  title: Text(productName),
                  subtitle: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _showUpdateDialog(context, product),
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
