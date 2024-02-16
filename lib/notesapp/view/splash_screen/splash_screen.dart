import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/notesapp/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=> const HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 230, 168),
      body: Center(
        child: LottieBuilder.asset("assets/animations/Animation - 1707286971716 (3).json",height: 200,),
      ),
    );
  }
}
