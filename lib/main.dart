import 'dart:async';

import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:Roomies/getDataFunctions.dart';
import 'package:Roomies/screens/createRoomScreen.dart';
import 'package:Roomies/screens/roomOverviewScreen.dart';
import 'package:Roomies/screens/settingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Roomies/screens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    return new Timer(Duration(seconds: 4), onDoneLoading);
  }

  void onDoneLoading() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splashScreenbg.jpg'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Roomies',
                  style: TextStyle(
                    fontFamily: 'primary',
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[100],
                    fontSize: 50,
                    letterSpacing: 9,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Create ChatRooms on GO!',
                  style: TextStyle(
                    fontFamily: 'secondary',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProfileProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          builder: (context, authSnapshot) {
            if (authSnapshot.hasData) {
              try {
                getUserRooms();
              } catch (err) {
                print(err);
              }
              return RoomOverviewScreen();
            }
            getUsedUsernames();
            return LoginScreen();
          },
          stream: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ),
    );
  }
}
