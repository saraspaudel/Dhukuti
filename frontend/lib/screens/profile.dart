import 'package:flutter/material.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
    _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey("signOut"),
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        Navigator.push (context, MaterialPageRoute(builder: (context) => Login()),);
      },
    );
  }
}
