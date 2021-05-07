import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/page/common/updateApp.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/welcome.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class WatchSplashScreen extends StatefulWidget {
  @override
  _WatchSplashScreenState createState() => _WatchSplashScreenState();
}

class _WatchSplashScreenState extends State<WatchSplashScreen> {
  Future<bool> _checkAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentAppVersion = "${packageInfo.version}";
    final appVersion = await _getAppVersionFromFirebaseConfig();
    if (appVersion != currentAppVersion) {
      print(currentAppVersion);
      print(appVersion);


      // if(kDebugMode){
      //   cprint("Latest version of app is not installed on your system");
      //   cprint("In debug mode we are not restrict devlopers to redirect to update screen");
      //   cprint("Redirect devs to update screen can put other devs in confusion");
      //   return true;
      // }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UpdateApp(),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  /// Returns app version from firebase config
  /// Fecth Latest app version from firebase Remote config
  /// To check current installed app version check [version] in pubspec.yaml
  /// you have to add latest app version in firebase remote config
  /// To fetch this key go to project setting in firebase
  /// Click on `cloud messaging` tab
  /// Copy server key from `Project credentials`
  /// Now goto `Remote Congig` section in fireabse
  /// Add [appVersion]  as paramerter key and below json in Default vslue
  ///  ``` json
  ///  {
  ///    "key": "1.0.0"
  ///  } ```
  /// After adding app version key click on Publish Change button
  /// For package detail check:-  https://pub.dev/packages/firebase_remote_config#-readme-tab-
  Future<String> _getAppVersionFromFirebaseConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(minutes: 1));
    await remoteConfig.activateFetched();
    var data = remoteConfig.getString('appVersion');
    print(data);
    if (data != null && data.isNotEmpty) {
      return jsonDecode(data)["key"];
    } else {
      cprint(
          "Please add your app's current version into Remote config in firebase",
          errorIn: "_getAppVersionFromFirebaseConfig");
      return null;
    }
  }
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }
  void timer() async {
    final isAppUpdated = await _checkAppVersion();
    if (isAppUpdated) {
      print("App is updated");
      Future.delayed(Duration(seconds: 1)).then((_) {
        var state = Provider.of<AuthState>(context, listen: false);
        // state.authStatus = AuthStatus.NOT_DETERMINED;
        state.getCurrentUser();
      });
    }
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
