import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/welcome.dart';
import 'package:provider/provider.dart';

class WatchSplashScreen extends StatefulWidget {
  @override
  _WatchSplashScreenState createState() => _WatchSplashScreenState();
}

class _WatchSplashScreenState extends State<WatchSplashScreen> {
Widget _body(){

  return SingleChildScrollView(
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        color: const Color(0xff000000),
        image: new DecorationImage(
          image: new AssetImage('assets/Background.png'),
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetAnimator(
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    "assets/LOGO.png",
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          WidgetAnimator(
            Text(
              "Elite Edge Ware",
              style: TextStyle(
                  color: secondary,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 35.0),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            height: 100,
            width: double.infinity,
            child: ScaleAnimatedTextKit(
              text: [
                " The World's Best ",
                " Social Media ",
                " Application ",
              ],
              textStyle: TextStyle(
                fontSize: 25.0,
                color: secondary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          WidgetAnimator(
            SpinKitWave(
              color: secondary,
              size: 30.0,
            ),
          )
        ],
      ),
    ),
  );
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds:5),
            (){
              //var state = Provider.of<AuthState>(context, listen: false);
              // state.authStatus = AuthStatus.NOT_DETERMINED;
              //state.getCurrentUser();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
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
