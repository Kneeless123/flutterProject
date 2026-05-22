import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A. M. Naik Complaint Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
     Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:  const Color(0xFF147A73),
                ),
                child: Icon(
                  Icons.warning_rounded,
                  size: 60,
                  color: const Color(0xFF147A73),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'A. M. Naik\nComplaint Manager',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF147A73), width: 4),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>( const Color(0xFF147A73)),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
