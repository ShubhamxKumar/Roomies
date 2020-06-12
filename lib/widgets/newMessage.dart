import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  final String roomid;
  NewMessage({this.roomid});
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserProfileProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'New Message',
              ),
              onChanged: (value) {
                // this function will fire with every keyStroke.
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.isEmpty
                ? null
                : () async {
                    final user = await FirebaseAuth.instance.currentUser();
                    Firestore.instance.collection('Rooms').document(widget.roomid).collection('chats').add(
                      {
                        'text': _enteredMessage,
                        'created': Timestamp.now(),
                        // this is class provided by cloud firestore which give us the time at which the document was created.
                        'userId': user.uid,
                        'username': userInfo.getusername,
                        // this will store the username also
                      },
                    );
                    FocusScope.of(context).unfocus();
                    setState(
                      () {
                        _textController.clear();
                        // it will clear the feild after sending the message.
                      },
                    );
                  },
          ),
        ],
      ),
    );
  }
}
