import 'package:BREW_CREW/services/auth.dart';
import 'package:BREW_CREW/shared/constants.dart';
import 'package:BREW_CREW/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  List<Widget> instructions = [
    Container(
      // width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instructions :-',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            'Please enter a valid email.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text('Please enter a valid password.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              )),
          SizedBox(
            height: 12.0,
          ),
          Text('Password must be 6 or more character long.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ))
        ],
      ),
    )
  ];

  String _validateEmail(String email) {
    email = email.trim();
    if (email.isEmpty) {
      return 'Enter valid Email';
    } else {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return (!regex.hasMatch(email)) ? 'Enter a valid Email' : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.primaries[4],
              elevation: 0.0,
              title: Text(
                'Authentication',
                style: TextStyle(fontSize: 25.0,fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,),
              ),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ))),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 50.0),
                  child: Column(children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) => _validateEmail(val),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.length < 6
                                ? 'Enter password 6 or more character long'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonTheme(
                            minWidth: double.infinity,
                            height: 60,
                            child: RaisedButton(
                                color: Colors.primaries[4],
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerUserWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Enter valid email or password';
                                      });
                                    }
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          ...instructions,
                        ],
                      ),
                    ),
                  ])),
            ),
          );
  }
}
