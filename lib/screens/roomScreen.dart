import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:Roomies/widgets/messBubble.dart';
import 'package:Roomies/widgets/newMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatefulWidget {
  String roomid;
  RoomScreen({this.roomid});
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserProfileProvider>(context);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/roomoverviewbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xff000033),
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Text(
              'Chat Room, id: ${widget.roomid}',
              style: TextStyle(
                fontFamily: 'primary',
                color: Colors.white,
                fontSize: 25,
                letterSpacing: 2.5,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  builder: (ctx, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return StreamBuilder(
                      builder: (context, chatsnapshot) {
                        if (chatsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          reverse: true,
                          itemBuilder: (context, index) {
                            return MessageBubble(
                              message: chatsnapshot.data.documents[index]
                                  ['text'],
                              username: userInfo.getusername,
                              key: ValueKey(chatsnapshot
                                  .data.documents[index].documentID),
                              isMe: chatsnapshot.data.documents[index]
                                      ['userId'] ==
                                  futureSnapshot.data.uid,
                            );
                          },
                          itemCount: chatsnapshot.data.documents.length,
                        );
                      },
                      stream: Firestore.instance
                          .collection('Rooms')
                          .document(widget.roomid)
                          .collection('chats')
                          .orderBy(
                            'created',
                            descending: true,
                          )
                          .snapshots(),
                    );
                  },
                  future: FirebaseAuth.instance.currentUser(),
                ),
              ),
              NewMessage(
                roomid: widget.roomid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
