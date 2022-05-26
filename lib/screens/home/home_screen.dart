import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_messendger/constants.dart';
import 'package:secure_messendger/screens/message_full_screen.dart';
import 'package:secure_messendger/screens/new_message.dart';
import 'package:secure_messendger/utils/db_provider.dart';
import 'package:secure_messendger/utils/message_storage.dart';
import 'package:secure_messendger/utils/requests.dart';

import 'message_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBProvider _dbProvider = DBProvider();
  Future<List<MessageInfo>> _messages;

  void loadMessages() {
    _messages = _dbProvider.getAllMessages();
    setState(() {});
  }

  void loadMessagesFromServerToDB() async {
    await getAllMessages().then((value) => {
          for (MessageInfo elem in value) {_dbProvider.insertMessage(elem)}
        });
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
              tooltip: "Load messages",
              icon: Icon(Icons.refresh),
              onPressed: () {
                loadMessagesFromServerToDB();
              })
        ],
      ),
      body: FutureBuilder(
          future: _messages,
          builder: (content, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessageFullScreen(snapshot.data[index])));
                    },
                    child: MessageWidget.withData(snapshot.data[index]),
                  );
                },
              );
            }
            return const Center(
              child: Text("Загрузка..."),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewMessage()));
        },
        tooltip: 'new message',
        child: Icon(Icons.messenger),
      ),
    );
  }
}
