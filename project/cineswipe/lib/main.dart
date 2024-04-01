import 'package:cineswipe/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineSwipe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF23272E),
        
      ),
      home: const HomeScreen(),
    );
  }
}
