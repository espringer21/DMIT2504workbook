// ignore_for_file: use_key_in_widget_constructors, todo

import 'dart:math';

import 'package:flutter/material.dart';

//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

//This app makes use of the Row, Column,
//Expanded, Padding, Transform, Container,
//BoxDecoration, BoxShape, Colors,
//Border, Center, Align, Alignment,
//EdgeInsets, Text, and TextStyle Widgets
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //first level widget of Material Design
      home: Scaffold(
        //default route
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text("App1 - UI Layout"),
          backgroundColor: Colors.blue,
        ),
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            //TODO: Put your code here to complete this app.
            Column(
              children: [Container1(), Container2()],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Container3(), Container4()],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container5(),
                SizedBox(height: 245.0),
                Container6(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Container1 extends StatelessWidget {
  const Container1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        color: Colors.amber,
      ),
      child: const Center(
        child: Text(
          'Container 1',
        ),
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  const Container2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            'Container 2',
          ),
        ),
      ),
    );
  }
}

class Container3 extends StatelessWidget {
  const Container3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      width: 100.0,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: const Text(
        'Container 3',
      ),
    );
  }
}

class Container4 extends StatelessWidget {
  const Container4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: 380.0,
      width: 100.0,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: const Text(
        'Container 4',
        textAlign: TextAlign.right,
      ),
    );
  }
}

class Container5 extends StatelessWidget {
  const Container5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Set the shape to circle
        border: Border.all(color: Colors.white, width: 3),
        color: Colors.black,
      ),
      child: const Text(
        'Container 5',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class Container6 extends StatelessWidget {
  const Container6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 200.0,
      width: 100.0,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: const Text(
        'Con 6',
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
