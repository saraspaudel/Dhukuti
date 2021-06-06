import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhukuti/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Registration({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _RegistrationState createState () => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "First Name"),
                  controller: _emailController,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Last Name"),
                  controller: _emailController,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Email"),
                  controller: _emailController,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () async {
                      final String retVal = await Auth(auth: widget.auth).createAccount(
                          email: _emailController.text,
                          password: _passwordController.text,
                      );
                      if(retVal == "Success"){
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(retVal),
                          ),
                        );
                      }
                    },
                    child: const Text("Create Account")
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}