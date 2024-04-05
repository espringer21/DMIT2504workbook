import 'package:cineswipe/widgets/Navbar.dart';
import 'package:flutter/material.dart';


class FavouriteMovieList extends StatelessWidget {
  const FavouriteMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
    );
  }
}