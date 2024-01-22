// ignore_for_file: use_key_in_widget_constructors, todo

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
          children: <Widget>[
            //TODO: Put your code here to complete this app.
            Column(
              children: <Widget> [
                Container1()
              ],

            ),
            Column(

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
          // decoration: ,
          height: 100.0,
          width: 100.0,
          color: Color.fromARGB(255, 254, 190, 25),
          child: const Center(
          child: Text(
          'Container 1',
        ),
      ),
    );
  }
}
