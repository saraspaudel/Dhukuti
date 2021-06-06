import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/screens/marketplace.dart';
import 'package:dhukuti/screens/profile.dart';
import 'package:dhukuti/screens/propose_loan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dhukuti/services/auth.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({Key key, this.auth, this.firestore}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MarketPlace(),
    ProposeLoan(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dhukuti"),
        centerTitle: true,
        actions: [
          IconButton(
            key: const ValueKey("signOut"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Propose Loan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
