import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? emailError;
  String? passwordError;

  void SignUp(String emailControl, String passControl) async {
    if (_key.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: emailControl, password: passControl);
        // Successful registration, navigate to the next screen
        Navigator.pushReplacementNamed(context, 'dashboard');
      } catch (e) {
        // Handle registration error
        print('Error during registration: $e');
      }
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
                'Create\nAccount',
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
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: emailError,
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'E-mail',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
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
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: passwordError,
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    right: MediaQuery.of(context).size.width *
                                        0.1),
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              setState(() {
                                emailError = null;
                                passwordError = null;
                              });
                              SignUp(emailController.text,
                                  passwordController.text);
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              },
                              child: const Text(
                                'Already Have Account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 17,
                                    color: Colors.black),
                              )),
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
