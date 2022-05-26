import 'package:flutter/material.dart';
import 'package:secure_messendger/utils/message_storage.dart';

class MessageWidget extends StatelessWidget{
  String from = "";
  String title = "";

  MessageWidget();

  MessageWidget.withData(MessageInfo item){
    from = item.from;
    title = item.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(20),
        decoration:  BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: "+from, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Text(title, style: TextStyle(fontSize: 15),),
          ],
        ),
      ),
    );
  }
}