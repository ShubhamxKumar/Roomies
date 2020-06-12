import 'package:Roomies/screens/roomScreen.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatefulWidget {
  String roomid;
  RoomTile({this.roomid});
  @override
  _RoomTileState createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => RoomScreen(
              roomid: widget.roomid,
            ),
          ),
        );
      },
      child: Container(
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
            Text(
              widget.roomid,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'secondary',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
