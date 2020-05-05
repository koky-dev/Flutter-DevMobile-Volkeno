import 'package:emailapp/AppDrawer.dart';
import 'package:emailapp/ContactCounter.dart';
import 'package:emailapp/ContactListBuilder.dart';
import 'package:emailapp/ContactSearchDelegate.dart';
import 'package:emailapp/Model/Contact.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          actions: <Widget>[
            ContactCounter(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: ContactSearchDelegate(),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ContactListBuilder(
          builder: (context, contacts) {
            return ListView.separated(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index){
                Contact _contact = contacts[index];
                return ListTile(
                  title: Text(_contact.name),
                  subtitle: Text(_contact.email),
                  leading: CircleAvatar(),
                );
              },  
              separatorBuilder: (context, index) => Divider(),
            );
          },
        )
      ),
      length: 2,
    );
    
    
  }
}