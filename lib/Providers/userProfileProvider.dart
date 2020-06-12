import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileProvider with ChangeNotifier {
  String name;
  String username;
  String email;
  String imgUrl;
  var _rooms ;

  Future<DocumentSnapshot> getUserInfo() async {
    try {
      await FirebaseAuth.instance.currentUser().then((value) async {
        await Firestore.instance
            .collection('Users')
            .document(value.uid)
            .get()
            .then((docSnapshot) {
          print(docSnapshot.data);
          name = docSnapshot.data["name"];
          username = docSnapshot.data["username"];
          email = docSnapshot.data["email"];
          _rooms = docSnapshot.data["rooms"];
          notifyListeners();
        });
      });
    } catch (err) {}
  }


  String get getname {
    return name;
  }

  String get getusername {
    return username;
  }

  String get getemail {
    return email;
  }

  List<dynamic> get getuserrooms {
    return _rooms;
  }
}
