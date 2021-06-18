import 'package:dhukuti/models/loan_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PickTurn extends StatefulWidget {
  final String loanId;

  PickTurn(this.loanId);

  @override
  _PickTurnState createState() => _PickTurnState();
}

class _PickTurnState extends State<PickTurn> {
  late String dropdownValue;
  late Future<LoanOrderList> futureLoanOrder;

  @override
  void initState() {
    super.initState();
    futureLoanOrder = fetchLoans(widget.loanId);
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
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Colors.blue,
                                ),
                                onChanged: (String? newValue) => setState(() {
                                  dropdownValue = newValue!;
                                }),
                                // items: snapshot.data.loans.toList(),
                                items: snapshot.data!.loans.map<DropdownMenuItem<String>>((LoanOrder value) {
                                  return DropdownMenuItem<String>(
                                    value: value.loanId.toString(),
                                    child: Text("Turn " + value.turn.toString() + " and " + value.interestRate.toString() + "% Interest Rate "),
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

Future<LoanOrderList> fetchLoans(String loanId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/loanOrder?loanId=' + loanId));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Ordering of Loan ID: " + loanId.toString() + response.body.toString());
    return LoanOrderList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load loan order');
  }
}
