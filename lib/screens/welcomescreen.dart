import 'package:flutter/material.dart';
import 'package:vpn_prog/screens/homefree.dart';
import 'package:vpn_prog/screens/signin.dart';
import 'package:vpn_prog/screens/textbox.dart';
import 'package:vpn_prog/random.dart';

class WelcomeSCreen extends StatefulWidget {
  const WelcomeSCreen({super.key});

  @override
  State<WelcomeSCreen> createState() => _WelcomeSCreenState();
}

class _WelcomeSCreenState extends State<WelcomeSCreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/signin.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
            ),
            child: Container(
              child: Text(
                'WELLCOME',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.19,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: 100,
                left: 100,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 31, 161, 179),
                  minimumSize: Size(270, 50),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreenFree(),
                    ));
              },
              child: Text(
                'Use Free Vpn',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                      //TextBox(),
                    ));
              },
              child: Text(
                'C . R . U . D',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
