import 'dart:convert';

MessageInfo clientFromJson(String str) {
  final jsonData = json.decode(str);
  return MessageInfo.fromMap(jsonData);
}

String clientToJson(MessageInfo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class MessageInfo{
  static int tempID = 400;

  int id;
  String title;
  String message;
  String from;

  MessageInfo({
    this.id,
    this.title,
     this.message,
     this.from
  });
  factory MessageInfo.fromJson(Map<String, dynamic> json)=>MessageInfo(
    id: json['id'],
    title: json['title'],
    message: json['message'],
    from: json['fromusername'],
  );
  factory MessageInfo.fromMap(Map<String, dynamic> json) =>
      MessageInfo(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        from: json["fromusername"],
      );
  Map<String, dynamic> toMap() => {
    "id":id,
    "title":title,
    "message":message,
    "fromusername":from,
  };

}