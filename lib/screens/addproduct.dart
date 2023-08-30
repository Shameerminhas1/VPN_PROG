import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Price'),
            ),
            ElevatedButton(
              onPressed: () {
                if (descriptionController.text.isEmpty &&
                    nameController.text.isEmpty &&
                    priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please! fill all fields')));
                } else {
                  FirebaseFirestore.instance.collection('products').add({
                    'description': descriptionController.text,
                    'name': nameController.text,
                    'price': double.parse(priceController.text),
                  });
                }
                nameController.clear();
                priceController.clear();
                descriptionController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('product added')),
                );
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
