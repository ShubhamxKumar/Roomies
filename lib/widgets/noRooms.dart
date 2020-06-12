import 'package:flutter/material.dart';

class NoRooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset(
              'assets/images/norooms.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              'No Rooms, Join or Create one!!',
              style: TextStyle(
                fontFamily: 'secondary',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
