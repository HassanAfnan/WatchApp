import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  Widget _body(){
    return Container(
      decoration: new BoxDecoration(
        //color: const Color(0xff000000),
        image: new DecorationImage(
          image: new AssetImage('assets/IMG-1811.PNG'),
          //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds:8),
            (){
          var state = Provider.of<AuthState>(context, listen: false);
          // state.authStatus = AuthStatus.NOT_DETERMINED;
          state.getCurrentUser();

        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      body: state.authStatus == AuthStatus.NOT_DETERMINED
          ? _body()
          : state.authStatus == AuthStatus.NOT_LOGGED_IN
          ? Login()
          : HomeScreen(),
    );
  }
}
