import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_display/number_display.dart';

class ProposeLoan extends StatefulWidget {
  @override
  _ProposeLoanState createState() => _ProposeLoanState();
}

class _ProposeLoanState extends State<ProposeLoan> {
  final moneyController = TextEditingController();
  final TextEditingController _poolParticipantsTotalController =
      TextEditingController();
  String dropdownValue = "";
  double _currentSliderValue = 2.0;

  final interestRateFormatter = createDisplay(
    length: 3,
    decimal: 2,
  );

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
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const ValueKey("addField"),
                      controller: moneyController,
                      decoration:
                          const InputDecoration(hintText: "Loan Amount \$"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9,]+')),
                      ],
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
                    child: DropdownButton<String>(
                      hint: new Text("Loan Payment Frequency"),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Weekly', 'Every 2 Weeks', 'Monthly']
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
                  Text(
                    "Interest Rate",
                    style: TextStyle(fontSize: 18, color: Color(0xFFA3A3A3)),
                  ),
                  Expanded(
                      child: Slider(
                    value: _currentSliderValue,
                    min: 0.0,
                    max: 5.0,
                    divisions: 100,
                    label:
                        interestRateFormatter(_currentSliderValue).toString() +
                            "\%",
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ))
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
                        decoration: const InputDecoration(
                            hintText: "Total Participants"),
                        keyboardType: TextInputType.number),
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
                      if (moneyController.text != "") {
                        setState(() {

                        });
                      } else {
                        print("Couldn't submit due to error in if statement");
                      }
                      _poolParticipantsTotalController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  )),
                ],
              ),
            ),
          ),
        ])));
  }
}
