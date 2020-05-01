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

  static Future<List<Message>> browse() async {
     
        http.Response listMessage = await http.get('http://www.mocky.io/v2/5eaa0f9d2d00007f00268470');

        await Future.delayed(Duration(seconds: 3));

        String content = listMessage.body;
        List collection = json.decode(content);
        List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();

        return _messages;
      }
}