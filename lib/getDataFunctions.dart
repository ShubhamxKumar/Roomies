import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var usedUsernames = [];
var currentUserRooms = [];
var userId;

Future<void> getUsedUsernames() async {
  try {
    QuerySnapshot querySnapshots =
        await Firestore.instance.collection('AppData').getDocuments();
    for (int i = 0; i < querySnapshots.documents.length; i++) {
      print(querySnapshots.documents[i]["data"]);
      usedUsernames = querySnapshots.documents[i]["data"];
      print(usedUsernames);
    }
  } catch (err) {
    print("Error encountered: ");
    print(err);
  }
}

Future<void> getUserRooms() async {
  try {
    await FirebaseAuth.instance.currentUser().then((value) async {
      await Firestore.instance
          .collection('Users')
          .document(value.uid)
          .get()
          .then((docSnapshot) {
        currentUserRooms = docSnapshot.data['rooms'];
      });
    });
  } catch (err) {
    print(err);
  }
  print(currentUserRooms);
}

Future<void> createRoom() {}
