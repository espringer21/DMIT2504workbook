import 'package:cineswipe/widgets/Navbar.dart';
import 'package:flutter/material.dart';


class TheatherLocation extends StatelessWidget {
  const TheatherLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
    );
  }
}