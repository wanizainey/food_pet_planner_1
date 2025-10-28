import 'package:food_pet_planner_1/homepage.dart'; 
import 'package:flutter/material.dart';

void main() {
  runApp(const PetFoodPlannerApp());
}

class PetFoodPlannerApp extends StatelessWidget {
  const PetFoodPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/catdog.png', height: 300),
            const SizedBox(height: 10),
            const Text(
              '🐾Pet Food Planner🐾',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Georgia',
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}

