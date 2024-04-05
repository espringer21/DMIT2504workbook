
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: GNav(
        tabBackgroundColor: const Color.fromARGB(255, 255, 230, 138),
        color: Colors.white,
        activeColor: const Color(0xFF23272E),
        gap: 8,
        padding: const EdgeInsets.all(16),
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.heart,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
        ],
      ),
    );
  }
}
