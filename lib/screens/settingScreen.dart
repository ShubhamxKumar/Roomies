import 'package:Roomies/Providers/userProfileProvider.dart';
import 'package:Roomies/widgets/settingsFeild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserProfileProvider>(context);
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
          'Settings',
          style: TextStyle(
            fontFamily: 'primary',
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 2.5,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Name: ',
                          style: TextStyle(
                            fontFamily: 'secondary',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SettingsFeild(
                          data: userInfo.getname,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Username: ',
                          style: TextStyle(
                            fontFamily: 'secondary',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SettingsFeild(
                          data: userInfo.getusername,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Email: ',
                          style: TextStyle(
                            fontFamily: 'secondary',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SettingsFeild(
                          data: userInfo.getemail,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  print('Logging out');
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(
                      fontFamily: 'secondary',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 40,
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.241875,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/owls.png'),
              ),
            ),
          ),
          Center(
            child: Text(
              'Hey! Night Owl',
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
