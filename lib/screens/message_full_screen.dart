import 'package:flutter/material.dart';
import 'package:secure_messendger/screens/new_message.dart';
import 'package:secure_messendger/utils/message_storage.dart';

class MessageFullScreen extends StatefulWidget {

  MessageInfo item;

  MessageFullScreen(this.item, {Key key}) : super(key: key);

  @override
  State<MessageFullScreen> createState() => _MessageFullScreenState();
}

class _MessageFullScreenState extends State<MessageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Message view"),
        ),
        body: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'From: ' +widget.item.from,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Theme: '+widget.item.title,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  Text(widget.item.message),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                          40), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          //todo add passing username to screen
                          MaterialPageRoute(builder: (context) => NewMessage.reply(widget.item.from)));
                    },
                    child: Text('Reply'),
                  ),

                ],
              ),
            )),
    );
  }
}
