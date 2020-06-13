import 'package:Roomies/getDataFunctions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchedRoomTile extends StatefulWidget {
  final String roomid;
  SearchedRoomTile({this.roomid});
  @override
  _SearchedRoomTileState createState() => _SearchedRoomTileState();
}

class _SearchedRoomTileState extends State<SearchedRoomTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        5,
      ),
      decoration: BoxDecoration(
        color: Color(0xff000033),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/roomicon.png'),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              widget.roomid,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'secondary',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (currentUserRooms == null ||
                  !currentUserRooms.contains(widget.roomid)) {
                currentUserRooms = [widget.roomid];
                FirebaseAuth.instance.currentUser().then((user) {
                  Firestore.instance
                      .collection('Users')
                      .document(user.uid)
                      .updateData({
                    'rooms': currentUserRooms,
                  });
                  print('Room joined');
                });
              } else if (currentUserRooms != null ||
                  !currentUserRooms.contains(widget.roomid)) {
                currentUserRooms.add(widget.roomid);
                FirebaseAuth.instance.currentUser().then((user) {
                  Firestore.instance
                      .collection('Users')
                      .document(user.uid)
                      .updateData({
                    'rooms': currentUserRooms,
                  });
                });
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You are already a member of this room'),
                    duration: Duration(
                      seconds: 3,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Join',
              style: TextStyle(
                fontFamily: 'secondary',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
