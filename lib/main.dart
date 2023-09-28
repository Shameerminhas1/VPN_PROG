import 'package:flutter/material.dart';
import 'package:vpn_prog/random.dart';
import 'package:vpn_prog/screens/dashboard.dart';
import 'package:vpn_prog/screens/deleteproduct.dart';
import 'package:vpn_prog/screens/dsplashscreen.dart';
import 'package:vpn_prog/screens/forget.dart';
import 'package:vpn_prog/screens/register.dart';
import 'package:vpn_prog/screens/signin.dart';

import 'package:vpn_prog/screens/update.dart';
import 'package:vpn_prog/screens/viewproduct.dart';
import 'package:vpn_prog/screens/welcomescreen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen', // Set your initial route here
    routes: {
      'splashscreen': (context) => SplashScreen(),
      'welcomescreen': (context) => WelcomeSCreen(),
      'home_screen': (context) => HomeScreen(),
      'register': (context) => Register(),
      'signin': (context) => SignIn(),
      'dashboard': (context) => Dashboard(),
      'forget': (context) => ForgetWindow(),
      'random': (context) => MyHomePage(),
      'viewproduct': (context) => ViewProductsScreen(),
      'deleteproduct': (context) => DeleteScreen(),
      'update': (context) => UpdateScreen()
    },
    onGenerateRoute: (settings) {
      return null;
    },
  ));
}




















// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialRoute: 'splashscreen',
//     routes: {
//       'splashscreen': (context) => SplashScreen(),
//       'home_screen': (context) => HomeScreen(),
//       'register': (context) => Register(),
//       'signin': (context) => SignIn(),
//       'dashboard': (context) => Dashboard(),
//     },
//   ));
// }