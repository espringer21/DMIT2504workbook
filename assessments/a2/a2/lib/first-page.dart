// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import './widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Enable Button'),
              Switch(
                  value: enabled,
                  onChanged: (bool onChangedValue) {
                    enabled = onChangedValue;
                    setState(() {
                      if (enabled) {
                        msg1 = 'Click Me';
                        msg2 = 'RESET';
                      }
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: enabled,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timesClicked++;
                          msg1 = 'Clicked $timesClicked';
                        });
                      },
                      child: Text(msg1),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timesClicked = 0;
                          msg1 = 'Click Me';
                        });
                      },
                      child: Text(msg2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //TODO: Build the text form field here as the first
                  // child of the column.
                  // Include as the second child of the column
                  // a submit button that will show a
                  // snackbar with the "firstName" if validation
                  // is satisfied.
                  TextFormField(
                    controller: textEditingController,
                    validator: (input) {
                      return input?.isEmpty ?? true
                          ? 'Please enter a name'
                          : null;
                    },
                    onSaved: (input) {
                      firstName = input;
                    },
                    maxLength: 10,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.hourglass_top),
                      labelText: 'fistName',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                  Padding(
                    
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'Click Me',
                                onPressed: () {
                                  print('Hey there, your name is $firstName');
                                },
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              content: 
                              Row(
                                children: [
                                  Icon(Icons.heart_broken,color: Colors.white,),
                                  SizedBox(width: 5,),
                                  Text('Hey There, your name is $firstName'),
                                ],
                              ),
                                  
                            ),
                          );
                        }
                      },
                      child: const Text('SUBMIT'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
