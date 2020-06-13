import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:Roomies/screens/newRoomScreen.dart';
import 'package:Roomies/screens/settingScreen.dart';
import 'package:Roomies/widgets/noRooms.dart';
import 'package:Roomies/widgets/roomTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Roomies/getDataFunctions.dart';

class RoomOverviewScreen extends StatefulWidget {
  @override
  _RoomOverviewScreenState createState() => _RoomOverviewScreenState();
}

class _RoomOverviewScreenState extends State<RoomOverviewScreen> {
  var refresh = 0;
  var count = 0;
  @override
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/roombg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xff000033),
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              'Rooms',
              style: TextStyle(
                fontFamily: 'primary',
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2.5,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    refresh = 0;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SettingScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: currentUserRooms == null || currentUserRooms.isEmpty
            ? NoRooms()
            : ListView(
                children: currentUserRooms.map((element) {
                  return RoomTile(
                    roomid: element,
                  );
                }).toList(),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff000033),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NewRoomScreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
