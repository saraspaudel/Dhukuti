import 'package:dhukuti/screens/registration.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home.dart';

Future<UserModel> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return UserModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    print("Invalid username or password");
    throw Exception('Incorrect username or password');
  }
  else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Server errors');
  }
}

class UserModel {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({required this.userId, required this.firstName, required this.lastName, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['email']
    );
  }
}

class Login extends StatefulWidget {

  @override
  _LoginState createState () => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<UserModel>? _futureUser;


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
                ElevatedButton(
                  onPressed: () async {
                      setState(() {
                        _futureUser = loginUser(_emailController.text, _passwordController.text);
                      });
                      UserModel? user = await _futureUser;
                      if(user != null){
                        Navigator.push (context, MaterialPageRoute(builder: (context) => Home()),);
                      }
                  },
                  child: const Text("Sign In"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push (context, MaterialPageRoute(builder: (context) => Registration()),);
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
