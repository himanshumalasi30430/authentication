import 'package:BREW_CREW/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home',style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          fontSize: 25.0
        ),),
        backgroundColor: Colors.primaries[8],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout',style: TextStyle(color: Colors.white,fontSize: 15.0),))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(child: Text('Welcome to the home page!!!!!!!!!!',style: TextStyle(fontSize: 30.0),)),),
      ),
    );
  }
}
