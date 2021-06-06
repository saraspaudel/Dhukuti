import 'package:cloud_firestore/cloud_firestore.dart';
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

  changeText() {
    setState(() {
      joinText = 'Joined';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money_outlined),
              title: Text('Loan Amount: \$${display(widget.loanPool.loanAmount)}'),
              subtitle: Text(
                  '''For ${widget.loanPool.loanDurationInDays} days\nEvery ${widget.loanPool.loanFrequencyInDays} days\nAt ${widget.loanPool.interestRate} % Interest\n${widget.loanPool.poolParticipantsTotal} Spaces Left
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
}
