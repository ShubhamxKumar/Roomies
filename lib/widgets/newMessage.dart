import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:Roomies/getDataFunctions.dart';
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
  var count = 0;

  void didChangeDependencies() {
    if (count < 1) {
      Provider.of<UserProfileProvider>(context).getUserInfo();
      getUserRooms();
      count++;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserProfileProvider>(context);
    print(userInfo.getusername);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                labelText: 'New Message',
                labelStyle: TextStyle(
                  fontFamily: 'secondary',
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 15,
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(40),
                    right: Radius.circular(40),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(40),
                    right: Radius.circular(40),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              onChanged: (value) {
                // this function will fire with every keyStroke.
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          SizedBox(width:10),
          FloatingActionButton(
            onPressed: _enteredMessage.isEmpty
                ? null
                : () async {
                    final user = await FirebaseAuth.instance.currentUser();
                    Firestore.instance
                        .collection('Rooms')
                        .document(widget.roomid)
                        .collection('chats')
                        .add(
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
            backgroundColor: Colors.white,
            child: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
