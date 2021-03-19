import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddWatch extends StatefulWidget {
  @override
  _AddWatchState createState() => _AddWatchState();
}

class _AddWatchState extends State<AddWatch> {
  int _radioValue1 = 0;
  int _radioValue2 = 1;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Watch"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return ListView(
            children: [
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        elevation: 5,
                        child: _image != null ? Image.file(_image,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                  ),
                ),
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
                        hintText: 'Enter brand',
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
                        hintText: 'Enter description',
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
                        hintText: 'Enter price',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Text('Condition',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
              WidgetAnimator(
                 ListTile(
                  title: const Text('Used Watch'),
                  leading: Radio(
                    value: 1,
                    activeColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                    groupValue: _radioValue1,
                    onChanged: (value){
                      setState(() {
                        _radioValue1 = value;
                      });
                    },
                  ),
                ),
              ),
              WidgetAnimator(
                 ListTile(
                  title: const Text('New Watch'),
                  leading: Radio(
                    value: 2,
                    activeColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                    groupValue: _radioValue1,
                    onChanged:(value){
                      setState(() {
                        _radioValue1 = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Text('Type',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
              WidgetAnimator(
                 ListTile(
                  title: const Text('Add To Sell'),
                  leading: Radio(
                    value: 1,
                    activeColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                    groupValue: _radioValue2,
                    onChanged:(value){
                      setState(() {
                        _radioValue2 = value;
                      });
                    },
                  ),
                ),
              ),
              WidgetAnimator(
                 ListTile(
                  title: const Text('Add To My Watches'),
                  leading: Radio(
                    value: 2,
                    activeColor: notifier.darkTheme ? Colors.white:Color(0xff151d3a),
                    groupValue: _radioValue2,
                    onChanged:(value){
                      setState(() {
                        _radioValue2 = value;
                      });
                    },
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
                      onPressed: (){}, child: Text('Add Watch',style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          );
        }
      )
    );
  }
}
