import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/forget_screen.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/signup_screen.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  TextEditingController _email=TextEditingController(),_password=TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CustomLoader loader;
  @override
  void initState() {
    // TODO: implement initState

    loader = CustomLoader();
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ThemeNotifier>(
          builder: (context,notifier,child) => SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                color: const Color(0xff000000),
                image: new DecorationImage(
                  image: new AssetImage('assets/Background.png'),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),BlendMode.dstATop),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:40),
                  WidgetAnimator(Text("Elite Edge Ware",style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),)),
                  SizedBox(height:30),
                  WidgetAnimator(
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            WidgetAnimator(Text("Sign In",style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w900),)),
                            SizedBox(height: 30,),
                            WidgetAnimator(
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    // set border color
                                  ),   // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)), // set rounded corner radius
                                ),
                                child: TextField(
                                  controller: _email,
                                   keyboardType: TextInputType.emailAddress,
                                  cursorColor: notifier.darkTheme ? Color(0xff151d3a) :primary,
                                  style: TextStyle(
                                      color: notifier.darkTheme ? Color(0xff151d3a) :primary
                                  ),
                                  decoration: InputDecoration(
                                    prefixText: "     ",
                                    hintStyle: TextStyle(
                                      color: Color(0xff151d3a)
                                    ),
                                    hintText: 'Enter your email',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            WidgetAnimator(
                              Container(
                                width: 300,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    // set border color
                                  ),   // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)), // set rounded corner radius
                                ),
                                child: TextField(
                                  controller: _password,
                                  cursorColor: Color(0xff151d3a),
                                  style: TextStyle(
                                      color: Color(0xff151d3a)
                                  ),
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                      prefixText: "    ",
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(
                                          color: Color(0xff151d3a)
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        color: primary,
                                        onPressed: (){
                                          setState(() {
                                            isHidden = !isHidden;
                                          });
                                        },
                                        icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            WidgetAnimator(
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgetScreen()));
                                },
                                child: Container(
                                  child: Text("Forget Your Password?",style: TextStyle(fontWeight: FontWeight.bold,color: primary),),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            WidgetAnimator(
                              FlatButton(
                                onPressed: (){
                                  _emailLogin();
                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                color: primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:10),
                  WidgetAnimator(
                    Text("OR",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900
                    ),),
                  ),
                 // SizedBox(height:10),
                  // WidgetAnimator(
                  //   SignInButton(
                  //       buttonType: ButtonType.google,
                  //       buttonSize: ButtonSize.large, // small(default), medium, large
                  //       onPressed: () {
                  //         print('click');
                  //       }),
                  // ),
                  // SizedBox(height: 10,),
                  // WidgetAnimator(
                  //   SignInButton(
                  //       buttonType: ButtonType.facebook,
                  //       buttonSize: ButtonSize.large, // small(default), medium, large
                  //       onPressed: () {
                  //         print('click');
                  //       }),
                  // ),
                  SizedBox(height:20),
                  WidgetAnimator(
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Container(
                        child: Text("Don't Have An Account? Register",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 15),),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }

  void _emailLogin() {
    var state = Provider.of<AuthState>(context, listen: false);
    if (state.isbusy) {
      return;
    }
    loader.showLoader(context);
    var isValid = validateCredentials(
        _scaffoldKey, _email.text, _password.text);
    if (isValid) {
      state
          .signIn(_email.text, _password.text,
          scaffoldKey: _scaffoldKey)
          .then((status) {
        if (state.user != null) {
          loader.hideLoader();

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              HomeScreen()), (Route<dynamic> route) => false);

         // widget.loginCallback();
        } else {
          cprint('Unable to login', errorIn: '_emailLoginButton');
          loader.hideLoader();
        }
      });
    } else {
      loader.hideLoader();
    }
  }
}
