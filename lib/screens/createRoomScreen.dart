import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
        backgroundColor: Color(0xff000033),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create A Room',
          style: TextStyle(
            fontFamily: 'primary',
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}
