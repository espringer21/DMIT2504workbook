import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('lib/assets/images/redmarker.png')
          ),
        ],
      )
    );
  }
}