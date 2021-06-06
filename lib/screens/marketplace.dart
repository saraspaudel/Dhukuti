import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/models/loanpool.dart';
import 'package:dhukuti/services/database.dart';
import 'package:dhukuti/widgets/loan_pool_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const MarketPlace({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Loan Pools",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Database(firestore: FirebaseFirestore.instance)
                  .streamTodos(uid: FirebaseAuth.instance.currentUser.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<LoanPoolModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No Loan pools available"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return LoanPoolCard(
                        firestore: widget.firestore,
                        uid: FirebaseAuth.instance.currentUser.uid,
                        loanPool: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("loading..."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
