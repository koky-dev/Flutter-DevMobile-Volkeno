import 'dart:ui';

import 'package:emailapp/Message.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouveau message"),
        ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return "Format d'adresse e-mail invalide";
                    }
                    else if (value.isEmpty) {
                      return "Veuillez remplir ce champ.";
                    }
                  },
                  onSaved: (value) => to = value,
                  decoration: InputDecoration(
                    labelText: 'A',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ),
            ListTile(
              title: TextFormField(
                  validator: (value) {
                    int len = value.length;
                    if (value.isEmpty) {
                      return "Veuillez remplir ce champs";
                    } else if(len < 4) {
                      return "Minimum 4 caractères";
                    }
                  },
                  onSaved: (value) => subject = value,
                  decoration: InputDecoration(
                    labelText: 'Objet',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ),
            ),
            
            Divider(),
            ListTile(
              title: TextFormField(
                  validator: (value) {
                    int len = value.length;
                    if (value.isEmpty) {
                      return "Veuillez remplir ce champs";
                    } else if(len < 15) {
                      return "Minimum 15 caractères";
                    }
                  },
                onChanged: (value) =>  body = value,
                decoration: InputDecoration(
                  labelText: 'Message',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 9,
              )
            ),
            ListTile(
              title: RaisedButton(
                child: Text("Envoyer"),
                onPressed: () {
                  if (this.key.currentState.validate()) {
                    key.currentState.save();
                    Message message = Message(subject, body);

                    Navigator.pop(context, message);
                  }
                },
              ),)
            ],
           ),
          ),
      )
    );
  }
}