import 'package:flutter/material.dart';

import 'AppDrawer.dart';
import 'MessagesList.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inbox"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), 
              onPressed: () async {
            })
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Importants"),
              Tab(text: "Autres"),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            MessageList(status: "important"),
            MessageList(status: "other"),
          ],
        ),
      ),
    length: 2,
    );
  }
}