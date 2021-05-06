import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/constant.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/page/Agreement.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/home_screen.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isHidden = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CustomLoader loader;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController name=TextEditingController(),email=TextEditingController(),password=TextEditingController(),confirm_password=TextEditingController();
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
      body: SingleChildScrollView(
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
                        WidgetAnimator(Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w900),)),
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
                              controller: name,
                              cursorColor: primary,
                              style: TextStyle(
                                  color: primary
                              ),
                              decoration: InputDecoration(
                                prefixText: "     ",
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                    color: Color(0xff151d3a)
                                ),
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
                              cursorColor: primary,
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  color: primary
                              ),
                              decoration: InputDecoration(
                                prefixText: "     ",
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                    color: Color(0xff151d3a)
                                ),
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
                              cursorColor: primary,
                              style: TextStyle(
                                  color: primary
                              ),
                              obscureText: isHidden,
                              controller: password,
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
                              cursorColor: primary,
                              style: TextStyle(
                                  color: primary
                              ),
                              obscureText: isHidden,
                              controller: confirm_password,
                              decoration: InputDecoration(
                                  prefixText: "    ",
                                  hintText: 'Confirm your password',
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
                           FlatButton(


                             onPressed: _submitForm,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            color: primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height:40),
              WidgetAnimator(
                GestureDetector(
                  onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    child: Text("Already Have An Account? Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 15),),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (email.text.isEmpty) {
      customSnackBar(_scaffoldKey, 'Please enter name');
      return;
    }
    // if (email.text.length > 27) {
    //   customSnackBar(_scaffoldKey, 'Name length cannot exceed 27 character');
    //   return;
    // }
    if (email.text == null ||
        email.text.isEmpty ||
        password.text == null ||
        password.text.isEmpty ||
        confirm_password.text == null||name.text==null||name.text.isEmpty) {
      customSnackBar(_scaffoldKey, 'Please fill form carefully');
      return;
    } else if (password.text != confirm_password.text) {
      customSnackBar(
          _scaffoldKey, 'Password and confirm password did not match');
      return;
    }

    loader.showLoader(context);
    var state = Provider.of<AuthState>(context, listen: false);
    Random random = new Random();
    int randomNumber = random.nextInt(8);

    UserModel user = UserModel(
      email: email.text.toLowerCase(),
      bio: 'Edit profile to update bio',
      // contact:  _mobileController.text,
      displayName:name.text,
      dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
          .toString(),
      location: 'Somewhere in universe',
      profilePic: dummyProfilePicList[randomNumber],
      isVerified: false,
    );

    loader.hideLoader();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            new CreateAgreement(user: user,password: password.text,)));
  }
}
