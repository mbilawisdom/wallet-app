import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> getUser(
      String email, String password, BuildContext localContext) async {
    final response = await http.post(
      "https://mywallet-api.herokuapp.com/login",
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email, 'password': password}),
    );

    final status = response.statusCode;

    if (status == 200) {
      final body = json.decode(response.body);
      Navigator.of(context).pushNamed(
        "home",
        arguments: {'id': body["user"]["id"]},
      );
    } else if (status == 400) {
      final body = json.decode(response.body);
      Scaffold.of(localContext).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            body["msg"],
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          action: SnackBarAction(
            label: "Undo",
            textColor: Colors.white,
            onPressed: () {

            },
          ),
        ),
      );
    } else {
      Scaffold.of(localContext).showSnackBar(
        SnackBar(
          content: Text(
            "Server side error, try again later.",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          action: SnackBarAction(
            label: "Undo",
            textColor: Colors.white,
            onPressed: () {

            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Wallet App",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: TextField(
                            controller: this._emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hoverColor: Theme.of(context).primaryColor,
                              contentPadding: const EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: TextField(
                            controller: this._passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      String email = this._emailController.text;
                      String password = this._passwordController.text;
                      this.getUser(email, password, context);
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
