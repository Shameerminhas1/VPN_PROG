import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  const TextBox({Key? key}) : super(key: key);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 0,
        left: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/signin.jpg')),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Text Box')),
          body: Container(
            padding: EdgeInsets.only(
              top: 250,
              right: 30,
              left: 30,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'prime'),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'prime'),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'prime'),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'prime'),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'prime'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
