import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _ProfileState();
    throw UnimplementedError();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Text('''Balance: \$40,000''',
              textAlign: TextAlign.center),
    );
  }
}
