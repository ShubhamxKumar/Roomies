import 'package:flutter/material.dart';

class SettingsFeild extends StatelessWidget {
  final String data;
  SettingsFeild({this.data = ''});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: data != ''
          ? Text(
              data,
              style: TextStyle(
                fontFamily: 'secondary',
                color: Colors.white,
                fontSize: 18,
              ),
            )
          : Text(
              'Add Info',
              style: TextStyle(
                fontFamily: 'secondary',
                color: Colors.grey, 
                fontSize: 18,
              ),
            ),
    );
  }
}
