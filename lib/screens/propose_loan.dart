import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProposeLoan extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const ProposeLoan({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _ProposeLoanState createState () => _ProposeLoanState();
}

class _ProposeLoanState extends State<ProposeLoan> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _loanDurationInDaysController = TextEditingController();
  final TextEditingController _loanFrequencyInDaysController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _poolParticipantsTotalController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Propose Loan Here:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: const ValueKey("addField"),
                        controller: _loanAmountController,
                        decoration: const InputDecoration(hintText: "Loan Amount \$"),
                        keyboardType: TextInputType.number
                      ),
                    ),
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
                      child: TextFormField(
                          key: const ValueKey("addField"),
                          controller: _loanDurationInDaysController,
                          decoration: const InputDecoration(hintText: "Loan Duration in Days"),
                          keyboardType: TextInputType.number
                      ),
                    ),
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
                      child: TextFormField(
                          key: const ValueKey("addField"),
                          controller: _loanFrequencyInDaysController,
                          decoration: const InputDecoration(hintText: "Loan Frequency in Days"),
                          keyboardType: TextInputType.number
                      ),
                    ),
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
                      child: TextFormField(
                          key: const ValueKey("addField"),
                          controller: _interestRateController,
                          decoration: const InputDecoration(hintText: "Interest Rate in %"),
                          keyboardType: TextInputType.number
                      ),
                    ),
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
                      child: TextFormField(
                          key: const ValueKey("addField"),
                          controller: _poolParticipantsTotalController,
                          decoration: const InputDecoration(hintText: "Total Participants"),
                          keyboardType: TextInputType.number
                      ),
                    ),
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
                          if (_loanAmountController.text != "" && _loanDurationInDaysController.text != "" && _loanFrequencyInDaysController.text != "" && _interestRateController.text != "" && _poolParticipantsTotalController.text != "") {
                            setState(() {
                              Database(firestore: FirebaseFirestore.instance).addTodo(
                                  uid: FirebaseAuth.instance.currentUser.uid,
                                  loanAmount: num.parse(_loanAmountController.text),
                                  loanDurationInDays: num.parse(_loanDurationInDaysController.text),
                                  loanFrequencyInDays: num.parse(_loanFrequencyInDaysController.text),
                                  interestRate: num.parse(_interestRateController.text),
                                  poolParticipantsTotal: num.parse(_poolParticipantsTotalController.text)
                              );
                              _loanAmountController.clear();
                              _loanDurationInDaysController.clear();
                            });
                          }
                        },
                      )
                    ),
                  ],
                ),
              ),
            ),
    ]
    )
    );
  }
}