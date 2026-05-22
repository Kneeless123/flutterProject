import 'package:flutter/material.dart';
import 'package:flutter_application_2/splash.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const HostelComplaintApp());
}

class HostelComplaintApp extends StatelessWidget {
  const HostelComplaintApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hostel Complain System',
      theme: ThemeData(
        primaryColor: const Color(0xFF00796B),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF147A73),
          secondary: const Color(0xFF147A73),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const MyApp(),
    );
  }
}