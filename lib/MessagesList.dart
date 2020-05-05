
import 'package:emailapp/MessageDetail.dart';
import 'package:flutter/material.dart';
import 'package:emailapp/Message.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class MessageList extends StatefulWidget {
final String title;
final String status;

  const MessageList({Key key, this.title, this.status = "important"}) : super(key: key);

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
  future = Message.browse(status: widget.status);
  messages = await future;
}
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return Container();
        },
    );
  }
}