import 'package:flutter/material.dart';
import 'widgets/fragmentplaceholder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FragmentPlaceholder(),
    );
  }
}

//hello 