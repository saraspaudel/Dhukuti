import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Profile({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Text('''Email: ${FirebaseAuth.instance.currentUser.email}\nBalance: \$40,000''',
              textAlign: TextAlign.center),
    );
  }
}
