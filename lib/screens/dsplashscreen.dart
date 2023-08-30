import 'package:flutter/material.dart';
import 'package:vpn_prog/screens/welcomescreen.dart';
import 'home_screen.dart'; // Import your HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward().then((value) {
      setState(() {
        _animationCompleted = true;
      });
      if (_animationController.isCompleted) {
        navigateToWelcomeSCreen();
      }
    });
  }

  void navigateToWelcomeSCreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeSCreen()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img.png',
                width: 350,
                height: 240,
              ),
              const SizedBox(height: 15),
              AnimatedOpacity(
                opacity: _animationCompleted ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: const Text(
                  'SHIELD VPN', // Fixed typo
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
