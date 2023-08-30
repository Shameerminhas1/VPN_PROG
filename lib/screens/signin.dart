import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vpn_prog/screens/forget.dart';
import 'package:vpn_prog/screens/home_screen.dart';
import 'package:vpn_prog/screens/welcomescreen.dart';
import 'register.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _key = GlobalKey<FormState>();

  //fb auth
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? emailError;
  String? passwordError;

  void SignIn(String emailControl, String passControl) async {
    if (_key.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: emailControl, password: passControl);

        // Successful login, navigate to the home screen
        Navigator.pushReplacementNamed(context, 'home_screen');
      } catch (e) {
        // Handle login error
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            setState(() {
              emailError = 'User not found. Please register first.';
            });
          } else if (e.code == 'wrong-password') {
            setState(() {
              passwordError = 'Incorrect password';
            });
          } else {
            print('Error during login: $e');
          }
        }
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
                'LOGIN',
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
                        keyboardType: TextInputType.text,
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        //keyboardType: TextInputType.text,
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
                                        0.09),
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));

                              setState(() {
                                emailError = null;
                                passwordError = null;
                              });
                              SignIn(emailController.text,
                                  passwordController.text);
                            },
                            child: const Text(
                              'SIGN IN',
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
                                        builder: (context) => Register()));
                              },
                              child: const Text(
                                'Dont have account ! Create account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
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
                                        builder: (context) => WelcomeSCreen()));
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 17,
                                    color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetWindow(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forget Password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 17,
                                    color: Colors.black),
                              ))
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
