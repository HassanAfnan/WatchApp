import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: (){},
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
}
