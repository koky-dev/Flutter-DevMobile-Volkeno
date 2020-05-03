import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable(nullable: false)
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) =>
   _$MessageFromJson(json);

  static Future<List<Message>> browse({status = "important"}) async {

      //http://www.mocky.io/v2/5eaf1b0f3300000e009f4320
        String url = status == "important" 
        ? "http://www.mocky.io/v2/5eaf1b0f3300000e009f4320" 
        : "http://www.mocky.io/v2/5eaa0f9d2d00007f00268470";
        http.Response listMessage = await http.get(url);

        await Future.delayed(Duration(seconds: 1));

        String content = listMessage.body;
        List collection = json.decode(content);
        List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();

        return _messages;
      }
}