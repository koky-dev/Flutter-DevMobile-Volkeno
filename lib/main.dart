import 'package:flutter/material.dart';
import 'package:emailapp/MessagesList.dart';

import 'App.dart';


void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.red),
      home: App(),
      debugShowCheckedModeBanner: false,
    );
  }
}
