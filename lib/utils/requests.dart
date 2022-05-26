import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:secure_messendger/utils/message_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const serverAddress = "1757-37-45-242-138.eu.ngrok.io";
const additionalRoute = "";

//метод для получения значения из Shared Preferences
getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString(key);
  return stringValue;
}
//метод для записи значения в Shared Preferences
saveValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}



//login
Future<void> postLogin(String username, String password) async{
  //String accessTokenSharedPref = await getValue('access_token') ?? "-"; // get token from shared preferences
  log("login: start request");
  var uri = Uri.https(serverAddress,additionalRoute+"/login");

  final response = await http.post(uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String, String>{
    'username': username,
    'password':password
    }),
  );
  if(response.statusCode == 200){
    log("login: request successfull");
    Map responseJson = json.decode(utf8.decode(response.bodyBytes));
    log('token data: '+ responseJson.toString());
    saveValue("access_token", responseJson['token']);
  }
  else{
    log("login: request unsuccessfull");
    log(response.body);
    log(response.statusCode.toString());
    throw Exception('Failed to login');
  }
}

//register
Future<void> postRegister(String username, String password) async{
  //String accessTokenSharedPref = await getValue('access_token') ?? "-"; // get token from shared preferences
  log("register: start request");
  var uri = Uri.https(serverAddress,additionalRoute+"/register");
  final response = await http.post(uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String, String>{
      'username': username,
      'password':password
    }),
  );
  if(response.statusCode == 201){
    log("register: request successfull");
    Map responseJson = json.decode(utf8.decode(response.bodyBytes));
    log('token data: '+ responseJson.toString());
    saveValue("access_token", responseJson['token']);
  }
  else{
    log("register: request unsuccessfull");
    log(response.body);
    log(response.statusCode.toString());
    throw Exception('Failed to register');
  }
}

//get message count

//get messages
Future<List<MessageInfo>> getAllMessages() async{
  String dateSharedPref = await getValue('requestDate') ?? "";
  String accessTokenSharedPref = await getValue('access_token') ?? "-"; // get token from shared preferences
  log("getAllMessages: start request");

  var uri = Uri.https(serverAddress,additionalRoute+"/get_messages");
  final response = await http.get(uri,
      headers: {
      "x-access-token":accessTokenSharedPref
      });
  if(response.statusCode == 200){
    log("getAllMessages: request successful");
    String dateFromResponse = response.headers[HttpHeaders.dateHeader];
    log(dateFromResponse);
    saveValue('requestDate', dateFromResponse);
    List responseJson = json.decode(utf8.decode(response.bodyBytes));
    return responseJson.map((e) => MessageInfo.fromJson(e)).toList();
  }
  else{
    log("getAllMessages: request unsuccessful");
    throw Exception('Failed to load Messages');
  }
}

//post messages
Future<void> postMessage(String title, String message, String to ) async{
  String accessTokenSharedPref = await getValue('access_token') ?? "-"; // get token from shared preferences
  log("post_message: start request");
  var uri = Uri.https(serverAddress,additionalRoute+"/post_message");
  final response = await http.post(
      uri,
    headers: <String, String>{
    "x-access-token":accessTokenSharedPref,
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body:jsonEncode(<String, String>{
      'title': title,
      'message':message,
      'to':to
    }),
  );
  if(response.statusCode == 201){
    log("post_message: request successfull");
  }
  else{
    log("post_message: request unsuccessfull");
    log(response.body);
    log(response.statusCode.toString());
    throw Exception('Failed to register');
  }
}