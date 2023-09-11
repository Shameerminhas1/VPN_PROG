import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data?.docs;
          return ListView.builder(
            itemCount: products?.length,
            itemBuilder: (context, index) {
              final product = products?[index];
              final productDescription = product?['description'];
              final productName = product?['name'];
              final productPrice = product?['price'];
              return Container(
                margin: EdgeInsets.all(5),
                color: Colors.amber,
                child: ListTile(
                  title: Text(productName),
                  subtitle: Text(productDescription),
                  trailing: Text('Price: \$${productPrice.toStringAsFixed(2)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
