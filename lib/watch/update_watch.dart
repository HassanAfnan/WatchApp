import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/constant.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/page/feed/composeTweet/state/composeTweetState.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateWatch extends StatefulWidget {
  final watchModel watch;

  const UpdateWatch({Key key, this.watch}) : super(key: key);
  @override
  _UpdateWatchState createState() => _UpdateWatchState();
}

class _UpdateWatchState extends State<UpdateWatch> {
  int _radioValue1 = 1;
  int _radioValue2 = 1;
  File _image;
  final picker = ImagePicker();
  TextEditingController brand = TextEditingController(),
      description = TextEditingController(),
      price = TextEditingController();
  String condition = "Used Watch", type = "Added To Sell";

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
  void initState() {
    // TODO: implement initState
    super.initState();
  description.text=widget.watch.description;
  brand.text=widget.watch.title;
  price.text=widget.watch.price;
  condition=widget.watch.condition;
  type=widget.watch.type;
_radioValue1=widget.watch.condition=="Used Watch"?1:2;

    _radioValue2=widget.watch.type=="Added To Sell"?1:2;
  }

  watchModel createwatchModel() {
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    var myUser = authState.userModel;
    var profilePic = myUser.profilePic ?? dummyProfilePic;
    var commentedUser = UserModel(
        displayName: myUser.displayName ?? myUser.email.split('@')[0],
        profilePic: profilePic,
        userId: myUser.userId,
        isVerified: authState.userModel.isVerified,
        userName: authState.userModel.userName);
    watchModel watch = watchModel(
        description: description.text,
        title: brand.text,
        user: commentedUser,
        createdAt: DateTime.now().toUtc().toString(),
        price: price.text,
        condition: condition,
        type: type,
        key: widget.watch.key,
        userId: myUser.userId);
    return watch;
  }

  void _submitButton() async {
    if (description.text == null || description.text.isEmpty) {
      return;
    }
    if (brand.text == null || brand.text.isEmpty) {
      return;
    }

    if (price.text == null || price.text.isEmpty) {
      return;
    }

    if (type == null || type.isEmpty) {
      return;
    }

    if (condition == null || condition.isEmpty) {
      return;
    }
    var state = Provider.of<FeedState>(context, listen: false);
    kScreenloader.showLoader(context);

    watchModel watch = createwatchModel();

    /// If tweet contain image
    /// First image is uploaded on firebase storage
    /// After sucessfull image upload to firebase storage it returns image path
    /// Add this image path to tweet model and save to firebase database
    try {
      if(_image!=null) {
        await state.uploadFile(_image).then((imagePath) {
          if (imagePath != null) {
            watch.imagePath = imagePath;

            /// If type of tweet is new tweet
            state.updateWatch(watch);
          }
        });
      }
      else{
watch.imagePath=widget.watch.imagePath;
        state.updateWatch(watch);
      }
      /// Checks for username in tweet description
      /// If foud sends notification to all tagged user
      /// If no user found or not compost tweet screen is closed and redirect back to home page.
      final composetweetstate =
      Provider.of<ComposeTweetState>(context, listen: false);
      final searchstate = Provider.of<SearchState>(context, listen: false);
      await composetweetstate.sendNotificationwatch(watch, searchstate).then((
          _) {
        /// Hide running loader on screen
        kScreenloader.hideLoader();

        /// Navigate back to home page
        Navigator.pop(context);
      });
    }catch(e){
      print(e);
      kScreenloader.hideLoader();


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.watch.title),
        ),
        body: Consumer<ThemeNotifier>(builder: (context, notifier, value) {
          return ListView(
            children: [
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 5,
                        child: _image != null
                            ? Image.file(_image, height: 200, width: 200)
                            : widget.watch.imagePath!=null?Image.network(widget.watch.imagePath,height: 200, width: 200):Image.asset("assets/placeholder-image.png",
                                height: 200, width: 200)),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          // set border color
                          ), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      controller: brand,
                      cursorColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a)),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a),
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
                  padding:
                      const EdgeInsets.only(top: 20, left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          // set border color
                          ), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      controller: description,
                      maxLines: 4,
                      cursorColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a)),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a),
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
                  padding:
                      const EdgeInsets.only(top: 20, left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          // set border color
                          ), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: TextField(
                      controller: price,
                      cursorColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a)),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a),
                        ),
                        hintText: 'Enter price',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Condition',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              WidgetAnimator(
                ListTile(
                  title: const Text('Used Watch'),
                  leading: Radio(
                    value: 1,
                    activeColor:
                        notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    groupValue: _radioValue1,
                    onChanged: (value) {
                      setState(() {

                        print(value);
                        _radioValue1 = value;
                        condition = "Used Watch";
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
                    activeColor:
                        notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    groupValue: _radioValue1,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _radioValue1 = value;

                        condition = "New Watch";
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              WidgetAnimator(
                ListTile(
                  title: const Text('Add To Sell'),
                  leading: Radio(
                    value: 1,
                    activeColor:
                        notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    groupValue: _radioValue2,
                    onChanged: (value) {
                      setState(() {
                        _radioValue2 = value;

                        type = "Add To Sell";
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
                    activeColor:
                        notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    groupValue: _radioValue2,
                    onChanged: (value) {
                      setState(() {
                        _radioValue2 = value;

                        type = "Add To My Watches";
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: primary,
                      onPressed: () {
                        _submitButton();
                      },
                      child: Text(
                        'Update Watch',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          );
        }));
  }

}
