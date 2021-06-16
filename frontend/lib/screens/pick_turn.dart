import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/screens/marketplace.dart';
import 'package:dhukuti/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_display/number_display.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PickTurn extends StatefulWidget {
  @override
  _PickTurnState createState() => _PickTurnState();
}

class _PickTurnState extends State<PickTurn> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: ListView(children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          hint: new Text("Pick your turn"),
                          isExpanded: true,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['1st 5% Interest', '2nd 4.8 Interest', '3rd 4.6% Interest', '4th 4.4% Interest', '5th 4.2% Interest']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            child: (Text("Submit")),
                            key: const ValueKey("addButton"),
                            onPressed: () {
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
