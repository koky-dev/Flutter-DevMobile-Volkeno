import 'package:emailapp/ContactManager.dart';
import 'package:emailapp/Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model/Contact.dart';

class ContactListBuilder extends StatelessWidget{
  @required
  final Function builder;

  const ContactListBuilder({this.builder});



  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of<ContactManager>(context);
    return  StreamBuilder(
        stream: manager.contactsListView,
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          
          List<Contact> contacts = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              List<Contact> contacts = snapshot.data;
              return builder(context, contacts);
          }
        },
      );
  }

}