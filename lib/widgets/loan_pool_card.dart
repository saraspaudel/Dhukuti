import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dhukuti/models/loanpool.dart';

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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money_outlined),
              title: Text('Loan Amount: ${widget.loanPool.loanAmount}'),
              subtitle: Text('For ${widget.loanPool.loanDurationInDays} days'),
            ),
            Text('Every ${widget.loanPool.loanFrequencyInDays} days'),
            Text('At ${widget.loanPool.interestRate} % Interest'),
            Text('${widget.loanPool.poolParticipantsTotal} Participants'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Details'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Join'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
