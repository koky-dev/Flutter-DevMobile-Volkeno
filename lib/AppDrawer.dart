import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("dramekoky@gmail.com"),
              accountName: Text("El Hadji Koky Dramé"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://avatars0.githubusercontent.com/u/52114675?s=460&u=c9054d7afacecbc04c9e5222db24e03be52327f4&v=4"),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Ajouter un nouveau compte"),
                          );
                      }
                    );
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text("Boîte de réception"),
              trailing: Chip(
                label: 
                    Text("10", style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.blue[100],
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text("Brouillons"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text("Messages Archivés"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text("Messages envoyés"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trash),
              title: Text("Corbeille"),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text("Paramètres"),
                ),
              ),
            )
          ],
        ),
      );
  }
}