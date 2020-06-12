import 'package:Roomies/getDataFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function authFunction;
  AuthForm({this.authFunction});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLogin = true;
  bool isPassVisible = false;
  bool isConfirmPassVisible = false;
  void _changePasswordVisibility() {
    setState(() {
      isPassVisible = !isPassVisible;
    });
  }

  var _passwordController = TextEditingController();

  void _changeConfirmPasswordVisibility() {
    setState(() {
      isConfirmPassVisible = !isConfirmPassVisible;
    });
  }

  var _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  var _name = '';

  Future<void> _saveData() {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      widget.authFunction(
        _email.trim(),
        _password,
        _name,
        _username,
        context,
        isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              isLogin ? 'Login' : 'Join the Community',
              style: TextStyle(
                fontFamily: 'secondary',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please fill out this feild';
                      }
                      if (!value.contains('@') || !value.contains('.com')) {
                        return 'Please Provide a valid email address';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _email = newValue;
                    },
                    style: TextStyle(
                      fontFamily: 'secondary',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLogin
                      ? SizedBox(
                          height: 0,
                        )
                      : TextFormField(
                          validator: (value) {
                            if (value.trim().contains(' ')) {
                              return 'No Spaces Allowed!';
                            }
                            if (usedUsernames.contains(value)) {
                              return 'Username Taken';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _username = newValue;
                          },
                          style: TextStyle(
                            fontFamily: 'secondary',
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
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
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  isLogin
                      ? SizedBox(
                          height: 0,
                        )
                      : TextFormField(
                          validator: (value) {
                            return null;
                          },
                          onSaved: (newValue) {
                            _name = newValue;
                          },
                          style: TextStyle(
                            fontFamily: 'secondary',
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
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
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value.length < 8) {
                        return 'Should be atleat 8 charachters long';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                    obscureText: !isPassVisible,
                    style: TextStyle(
                      fontFamily: 'secondary',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isPassVisible
                            ? Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          _changePasswordVisibility();
                        },
                      ),
                      labelText: 'Password',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLogin
                      ? SizedBox(
                          height: 0,
                        )
                      : TextFormField(
                          validator: (value) {
                            if (value == _passwordController.text) {
                              return null;
                            }
                            return 'Password don\'t match!';
                          },
                          obscureText: !isConfirmPassVisible,
                          style: TextStyle(
                            fontFamily: 'secondary',
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: isConfirmPassVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                              onPressed: () {
                                _changeConfirmPasswordVisibility();
                              },
                            ),
                            labelText: 'Confirm Password',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
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
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                _saveData();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isLogin ? 'Login' : 'Sign Up',
                  style: TextStyle(
                    fontFamily: 'secondary',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                !isLogin ? 'Already A User? Log in' : 'Not A User? Signup',
                style: TextStyle(
                  fontFamily: 'secondary',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
