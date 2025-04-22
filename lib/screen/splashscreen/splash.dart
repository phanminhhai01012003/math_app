import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/screen/main/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }
  @override
  void initState() {
    super.initState();
    navigateToHome(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonConstants.splashbgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/techlead.png",
              fit: BoxFit.cover,
              width: 189,
              height: 186,
            ),
          ],
        ),
      ),
    );
  }
}