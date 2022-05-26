import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:secure_messendger/screens/home/home_screen.dart';
import 'package:secure_messendger/screens/register_screen.dart';
import 'package:secure_messendger/utils/requests.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  void buttonLoginClickHandler() async {
    if ((_formKey.currentState.validate())) {
      try {
        await postLogin(usernameController.text, passwordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (_) {
        log("login screen: exception while login(");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Login"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username'),
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter username';
                  }
                  return null;
                },
              ),
              Text('Password'),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter password';
                  }
                  return null;
                },
              ),
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: buttonLoginClickHandler,
                child: Text('Login'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text('To registration page'))
            ],
          )),
    );
  }
}
