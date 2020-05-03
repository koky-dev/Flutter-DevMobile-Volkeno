import 'package:emailapp/CalendarScreen.dart';
import 'package:emailapp/ContactsScreen.dart';
import 'package:emailapp/InboxScreen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : [
        InboxScreen(),
        ContactsScreen(),
        CalendarScreen(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Accueil"),
            icon: Icon(Icons.mail),
          ),
          BottomNavigationBarItem(
            title: Text("Contacts"),
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            title: Text("Calendrier"),
            icon: Icon(Icons.calendar_today),
          )
        ],
        onTap: _onBarItemTap,
        currentIndex: _selectedIndex,
      ),
    );
  }
        
  void _onBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}