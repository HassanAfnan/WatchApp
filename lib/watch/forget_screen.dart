import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:provider/provider.dart';
class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController email=TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    final state = Provider.of<AuthState>(context);
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
              SizedBox(height:20),
              WidgetAnimator(
                GestureDetector(
                  child: Container(
                    child: Text("You will receive an email to reset password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 15),),
                  ),
                ),
              ),
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
                        WidgetAnimator(Text("Forget Password",style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.w900),)),
                        SizedBox(height: 30,),
                        WidgetAnimator(
                          Container(
                            width: 300,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                // set border color
                              ),   // set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: email,
                              cursorColor: primary,
                              style: TextStyle(
                                  color: primary
                              ),
                              decoration: InputDecoration(
                                prefixText: "     ",
                                hintText: 'Enter your email',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        WidgetAnimator(
                          FlatButton(
                            onPressed: () async {
                              if(email.text.isEmpty||email.text==null){
                                return;
                              }
                              try {

                                final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                                await _firebaseAuth.sendPasswordResetEmail(email: email.text);
                              customSnackBar(_scaffoldKey, "Reset link send to email");
                              }
                              catch(e){
                                customSnackBar(_scaffoldKey, e.toString());

                              }
                              },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            color: primary,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
                    child: Text("Back to login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 15),),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
