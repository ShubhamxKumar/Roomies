import 'package:Roomies/getDataFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Roomies/widgets/authForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loader = false;
  AuthResult _authResult;
  var _auth = FirebaseAuth.instance;
  Future<void> _authFunction(
    String email,
    String password,
    String name,
    String username,
    BuildContext ctx,
    bool isLogin,
  ) async {
    if (isLogin) {
      setState(() {
        _loader = true;
      });
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_authResult.user.uid);
      userId = _authResult.user.uid;
      setState(() {
        _loader = false;
      });
    }
    if (isLogin == false) {
      setState(() {
        _loader = true;
      });
      try {
        usedUsernames.add(username);
        await Firestore.instance
            .collection('AppData')
            .document('Usernames')
            .updateData({
          "data": usedUsernames,
        });
      } catch (err) {
        print(err);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
            duration: Duration(seconds: 3),
          ),
        );
      }
      _authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userId = _authResult.user.uid;
      Firestore.instance
          .collection('Users')
          .document(_authResult.user.uid)
          .setData({
        'email': email,
        'username': username,
        'name': name,
      });
      setState(() {
        _loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/lockscreenbg.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
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
                _loader
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : AuthForm(
                        authFunction: _authFunction,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
