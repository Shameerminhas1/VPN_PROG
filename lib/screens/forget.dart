import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vpn_prog/screens/signin.dart';

class ForgetWindow extends StatefulWidget {
  const ForgetWindow({super.key});

  @override
  State<ForgetWindow> createState() => _ForgetWindowState();
}

class _ForgetWindowState extends State<ForgetWindow> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  String? emailError;

  Future reset(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      await _auth.sendPasswordResetEmail(email: email);
      print('error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password Reset link sent! Check your Email'),
          );
        },
      );
      print('error');
    } catch (e) {
      Get.snackbar("About Password", "Reset message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Email not found"),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/signin.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: const Text(
                'RESET PASSWORD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                  right: 35,
                  left: 35,
                ),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: emailError, // Display the error message
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email field is required';
                          }
                          if (!isValidEmail(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          reset(context, emailController.text);
                          setState(() {
                            emailError = null;
                          });
                        },
                        child: const Text(
                          'RESET',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
