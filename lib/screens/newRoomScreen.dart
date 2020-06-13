import 'package:Roomies/widgets/searchedRoomTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Roomies/getDataFunctions.dart';

class NewRoomScreen extends StatefulWidget {
  @override
  _NewRoomScreenState createState() => _NewRoomScreenState();
}

class _NewRoomScreenState extends State<NewRoomScreen> {
  var _textController = TextEditingController();
  List<String> _foundedItems = [];
  var searchedValue = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/joincreate.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
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
            centerTitle: true,
            title: Text(
              'Join/Create Rooms',
              style: TextStyle(
                fontFamily: 'primary',
                color: Colors.white,
                fontSize: 30,
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
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Firestore.instance
                        .collection('AppData')
                        .document('Rooms')
                        .get()
                        .then((doc) {
                      print(doc.data['number']);
                      Firestore.instance
                          .collection('Rooms')
                          .document('Room${doc.data['number']}')
                          .setData({
                        'id': 'Room${doc.data['number']}',
                      }).then((val) {
                        Firestore.instance
                            .collection('AppData')
                            .document('Rooms')
                            .updateData({
                          'number': doc.data['number'] + 1,
                        }).then((val) async {
                          currentUserRooms.add('Room${doc.data['number']}');
                          FirebaseAuth.instance.currentUser().then((user) {
                            Firestore.instance
                                .collection('Users')
                                .document(user.uid)
                                .updateData({
                              'rooms': currentUserRooms,
                            }).then((val){
                              Navigator.of(context).pop();
                            });
                          });
                        });
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  child: Text(
                    'Enter Room id to join',
                    style: TextStyle(
                        fontFamily: 'secondary',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          labelText: 'Search.....',
                          labelStyle: TextStyle(
                            fontFamily: 'secondary',
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40),
                              right: Radius.circular(40),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40),
                              right: Radius.circular(40),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchedValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: searchedValue.isEmpty
                          ? null
                          : () {
                              setState(() {
                                _foundedItems = [];
                              });
                              var id = 'Room' + searchedValue.substring(4);
                              Firestore.instance
                                  .collection('Rooms')
                                  .document(id)
                                  .get()
                                  .then((doc) {
                                if (doc.exists) {
                                  setState(() {
                                    print(doc.documentID);
                                    _foundedItems.add(doc.documentID);
                                  });
                                  print(_foundedItems);
                                } else {
                                  setState(() {
                                    print('No Rooms found');
                                    _foundedItems = [];
                                  });
                                }
                              });
                            },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: _foundedItems.isEmpty
                    ? Text(
                        'No Rooms Found',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: 'secondary',
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      )
                    : Column(
                        children: _foundedItems.map((element) {
                          return SearchedRoomTile(roomid: element);
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
