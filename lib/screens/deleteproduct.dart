import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteScreen extends StatelessWidget {
  Future<void> deleteItem(DocumentSnapshot product) async {
    final docRef =
        FirebaseFirestore.instance.collection('products').doc(product.id);
    await docRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Screen'),
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
                        onPressed: () => deleteItem(product),
                        icon: Icon(Icons.delete),
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
