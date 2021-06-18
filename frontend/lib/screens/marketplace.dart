import 'package:dhukuti/models/loanpool.dart';
import 'package:dhukuti/widgets/loan_pool_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketPlace extends StatefulWidget {
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  late Future<LoanPoolList> futureLoans;

  @override
  void initState() {
    super.initState();
    futureLoans = fetchLoans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<LoanPoolList>(
                future: futureLoans,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                  }
                  else if (snapshot.data!.isEmpty()) {
                    print("No Loan pools available.");
                    return const Text("No Loan pools available");
                  }
                  else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.loans.length,
                      itemBuilder: (_, index) {
                        return LoanPoolCard(
                          loanPool: snapshot.data!.loans[index],
                        );
                      },
                    );
                    // return Text(snapshot.data.loans[0].loanAmount.toString());
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Future<LoanPoolList> fetchLoans() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/loans'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Loans: " + response.body.toString());
    return LoanPoolList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load loans');
  }
}
