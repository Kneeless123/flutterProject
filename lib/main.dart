import 'package:flutter/material.dart';
import 'widgets/mywidget.dart';

void main() {  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hostel Complaint",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ComplaintScreen() ,
    );
  }
}