import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name=TextEditingController(),email=TextEditingController(),comment=TextEditingController();
  CustomLoader loader;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loader = CustomLoader();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      controller: name,
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
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: comment,
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
                      onPressed: (){
                        sendquery();

                      }, child: Text('Send',style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          );
        },
      )
    );
  }
  sendquery(){
    if (name.text == null ||
        name.text.isEmpty ||
        email.text == null ||
        email.text.isEmpty ||
        comment.text == null||comment.text.isEmpty) {
      customSnackBar(_scaffoldKey, 'Please fill form carefully');
      return;
    }

    loader.showLoader(context);
    try {
      var authstate = Provider.of<AuthState>(context, listen: false);

      var body = {
        "comment": comment.text,
        "user":authstate.userModel.toJson(),
        "createdAt":DateTime.now()
      };
      kDatabase.child('queries').push().set(body);
      loader.hideLoader();
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: "Success",
        message: "Your request is send to admin",
        duration: Duration(seconds: 3),)
        ..show(context);
      setState(() {
        name.text="";
        email.text="";
        comment.text="";
      });

    }
    catch(e){
      loader.hideLoader();
      customSnackBar(_scaffoldKey, 'Error sending your query.Try later');

    }
  }
}
