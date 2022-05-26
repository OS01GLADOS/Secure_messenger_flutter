import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_messendger/screens/home/home_screen.dart';
import 'package:secure_messendger/screens/login_screen.dart';
import 'package:secure_messendger/utils/requests.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRepeatController = TextEditingController();

  void buttonRegisterClickHandler() async {
    if ((_formKey.currentState.validate())) {
      try {
        await postRegister(usernameController.text, passwordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (_) {
        log("register screen: exception while registering(");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Register"),
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
                      return 'enter username';
                    }
                    return null;
                  },
                ),
                Text('Repeat password'),
                TextFormField(
                  controller: passwordRepeatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter username';
                    }
                    else if(passwordController.text!= value){
                      return 'passwords are not the same';
                    }
                    return null;
                  },
                ),
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: buttonRegisterClickHandler,
                  child: Text('Register'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('To login page'))
              ],
            )));
  }
}
