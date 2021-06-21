import 'package:dhukuti/screens/pick_turn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dhukuti/models/loanpool.dart';
import 'package:number_display/number_display.dart';

class LoanPoolCard extends StatefulWidget {
  final LoanPoolModel loanPool;

  const LoanPoolCard({ Key? key, required this.loanPool})
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
                  '''Paid every ${widget.loanPool.loanFrequencyInDays} days\nAt ${widget.loanPool.loanInterestRate} % Interest\n${widget.loanPool.totalParticipants} Participants
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
                      // _firstPressJoinBtn = false;
                      // changeText();
                      Navigator.push (context, MaterialPageRoute(builder: (context) => PickTurn(widget.loanPool.loanId)),);
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
