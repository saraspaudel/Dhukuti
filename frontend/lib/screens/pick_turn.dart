import 'package:dhukuti/models/loan_order.dart';
import 'package:dhukuti/screens/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PickTurn extends StatefulWidget {
  final String loanId;

  PickTurn(this.loanId);

  @override
  _PickTurnState createState() => _PickTurnState();
}

class _PickTurnState extends State<PickTurn> {
  String? dropdownValue;
  late Future<LoanOrderList> futureLoanOrder;
  bool loading = true;

  @override
  void initState() {
    futureLoanOrder = fetchLoans(widget.loanId);
    super.initState();
  }

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
                  Center(
                    child: FutureBuilder<LoanOrderList>(
                      future: futureLoanOrder,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton<String>(
                            hint: new Text("Pick your turn"),
                            isExpanded: false,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            value: dropdownValue,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (String? newValue) => setState(() {
                              print("Dropdown value changes to " + newValue!);
                              dropdownValue = newValue.toString();
                            }),
                            // items: snapshot.data.loans.toList(),
                            items: snapshot.data!.loans
                                .map<DropdownMenuItem<String>>(
                                    (LoanOrder value) {
                              return DropdownMenuItem<String>(
                                value: value.loanOrderId.toString(),
                                child: Text("Turn " +
                                    value.turn.toString() +
                                    " and " +
                                    value.interestRate.toString() +
                                    "% Interest Rate "),
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
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
                    child: (Text("Join Loan")),
                    key: const ValueKey("addButton"),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getInt('userId') ?? 0;
                      int retVal = await pickTurn(userId, int.parse(dropdownValue!));
                      if (retVal == 201) {
                        Navigator.push (context, MaterialPageRoute(builder: (context) => MarketPlace()),);
                      } else {
                        CircularProgressIndicator();
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
        ])));
  }
}

Future<LoanOrderList> fetchLoans(String loanId) async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:3000/loanOrder?loanId=' + loanId));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(
        "Ordering of Loan ID: " + loanId.toString() + response.body.toString());
    return LoanOrderList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load loan order');
  }
}

Future<int> pickTurn(int userId, int loanOrderId) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/pickTurn'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, int>{'userId': userId, 'loanOrderId': loanOrderId}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return 201;
  } else if (response.statusCode == 401) {
    print("Invalid username or password");
    throw Exception('Incorrect username or password');
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Server errors');
  }
}
