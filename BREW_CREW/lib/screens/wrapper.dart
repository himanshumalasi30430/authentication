import 'package:BREW_CREW/models/user.dart';
import 'package:BREW_CREW/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//    print(user);
    // return either home or authenticate widget

    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
