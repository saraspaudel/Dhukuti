import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/screens/pick_turn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dhukuti/models/loanpool.dart';
import 'package:number_display/number_display.dart';

class LoanPoolCard extends StatefulWidget {
  final LoanPoolModel loanPool;
  final FirebaseFirestore firestore;
  final String uid;

  const LoanPoolCard({Key key, this.loanPool, this.firestore, this.uid})
      : super(key: key);

  @override
  _LoanPoolCardState createState() => _LoanPoolCardState();
}

class _LoanPoolCardState extends State<LoanPoolCard> {
  String joinText = 'Join';
  var _firstPressJoinBtn = true;
  final display = createDisplay(
    length: 8,
    decimal: 0,
  );
  String dropdownValue = 'One';

  changeText() {
    setState(() {
      joinText = 'Joined';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money_outlined),
              title:
                  Text('Loan Amount: \$${display(widget.loanPool.loanAmount)}'),
              subtitle: Text(
                  '''Paid In ${widget.loanPool.loanFrequencyInDays}\nAt ${widget.loanPool.interestRate} % Interest\n${widget.loanPool.poolParticipantsTotal} Spaces Left
                             '''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Details'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  child: Text('$joinText'),
                  onPressed: () {
                    if (_firstPressJoinBtn) {
                      _firstPressJoinBtn = false;
                      changeText();
                      widget.loanPool.poolParticipantsTotal--;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PickTurn()));
                    }
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose your turn'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your turn determines your interest rate'),
                DropdownButton<String>(
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
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
