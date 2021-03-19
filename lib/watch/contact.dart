import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact Us"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left:28.0,right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        // set border color
                      ),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      cursorColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a)
                      ),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                        ),
                        hintText: 'Enter Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(top:20,left:28.0,right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        // set border color
                      ),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      cursorColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a)
                      ),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                        ),
                        hintText: 'Enter Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(top:20,left:28.0,right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        // set border color
                      ),   // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      maxLines: 4,
                      cursorColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a)
                      ),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                        ),
                        hintText: 'Enter Comment',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left:28.0,right:28.0),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      color: primary,
                      onPressed: (){}, child: Text('Send',style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          );
        },
      )
    );
  }
}
