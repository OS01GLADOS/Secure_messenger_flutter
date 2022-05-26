import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_messendger/screens/home/home_screen.dart';
import 'package:secure_messendger/utils/requests.dart';

class NewMessage extends StatefulWidget {
  String _item = "";

  NewMessage({Key key}) : super(key: key){
    _item = "";
  }

  NewMessage.reply(this._item, {Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState(_item);
}

class _NewMessageState extends State<NewMessage> {

  String to_username = "";

  _NewMessageState(this.to_username){
    usernameController.text = to_username;
  }

  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var headerController = TextEditingController();
  var messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    void buttonSendMessageClickHandler() async {
      if ((_formKey.currentState.validate())) {
        await postMessage(headerController.text,messageController.text, usernameController.text);
        try {
        } catch (_) {
          log("new message screen: exception while sending a message(");
        }
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('message sended')));
        Navigator.pop(context);
      }
    }


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("New message"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter username';
                  }
                  return null;
                },
              ),
              Text("To:"),
              TextFormField(
                controller: headerController,
                validator: (value) {
                  bool messageThemeValid = RegExp(r"^[\S]+").hasMatch(value);
                  if (!messageThemeValid) {
                    return 'invalid header';
                  }
                  return null;
                },
              ),
              Text("Theme"),
              TextFormField(
                controller: messageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter message text';
                  }
                  return null;
                },
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(hintText: "Your message"),
              ),
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: buttonSendMessageClickHandler,
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
