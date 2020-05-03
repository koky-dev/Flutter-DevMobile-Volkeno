
import 'package:emailapp/MessageDetail.dart';
import 'package:flutter/material.dart';
import 'package:emailapp/Message.dart';
import 'package:emailapp/ComposeButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class MessageList extends StatefulWidget {
final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
Future<List<Message>> future;
List<Message> messages;



void initState(){
  super.initState();

 fetch();
}

void fetch() async {
  future = Message.browse();
  messages = await future;
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), 
            onPressed: () async {
            setState(() {
              future = Message.browse();
            });
          })
        ],
      ),
      drawer: Drawer(
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
      ),
      body: FutureBuilder(
        future: future, 
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              var messages = snapshot.data;
              if(snapshot.hasError)
                return Text("Il y a eu une erreur : ${snapshot.error}");
              return  ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index){
                  Message message = messages[index];

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Archiver',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () {

                        },
                      ),
                      IconSlideAction(
                        caption: 'Partager',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () {

                        },
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Plus',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () {

                        },
                      ),
                      IconSlideAction(
                        caption: 'Supprimer',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => {
                          setState( () {
                             messages.removeAt(index);
                          }),
                         
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(message.subject),
                      isThreeLine: false,
                      leading: CircleAvatar(
                        child: Text("KD"),
                        ),
                        subtitle: Text(
                          message.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (BuildContext context) => MessageDetail(message.subject, message.body)
                              ),
                          );
                        },
                    ),
                    key: ObjectKey(message),
                  );
                }
              );
          }
        },
        ),
        floatingActionButton: ComposeButton(messages),
    );
  }
}