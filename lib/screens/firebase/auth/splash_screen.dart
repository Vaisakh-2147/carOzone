import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_o_zone/screens/firebase/auth/login_user.dart';
import 'package:car_o_zone/screens/firebase/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Duration allowedDuration = const Duration(minutes: 3);

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    if (FirebaseAuth.instance.currentUser != null) {
      gotoHome(context);
      return;
    }

    gotoLogin(context);
  }

  Future<void> gotoHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'car'),
                      TextSpan(
                        text: 'O',
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                      TextSpan(text: 'zone'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              'Assets/images/olav-tvedt--oVaYMgBMbs-unsplash-removebg-preview.png',
              width: 800,
              height: 600,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
