import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/constant.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/model/watch_model_Model.dart';
import 'package:flutter_twitter_clone/page/feed/composeTweet/state/composeTweetState.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

class AddWatch extends StatefulWidget {
  @override
  _AddWatchState createState() => _AddWatchState();
}

class _AddWatchState extends State<AddWatch> {
  int _radioValue1 = 0;
  int _radioValue2 = 1;
  int _radioValue3 = 3;
  int _radioValue4 = 4;

  File _image;
  final picker = ImagePicker();
  TextEditingController brand = TextEditingController(),
      description = TextEditingController(),
      price = TextEditingController(),
      trade_price = TextEditingController(),

      sales_price = TextEditingController(),
      model_number = TextEditingController(),
  new_brand=TextEditingController(),
  new_model=TextEditingController();
  String condition = "Used Watch", type = "Add To Sell", sell_type = "both";
  bool fully_boxed = false;
  int watchcondition = 0;

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
        fully_boxed: fully_boxed,
        selltype: sell_type,
        watch_condition: watchcondition,
        sales_price: sales_price.text==null?'0':sales_price.text,
        trades_price: trade_price.text==null?'0':trade_price.text,
        model_number: model_number.text,
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
    if (model_number.text == null || model_number.text.isEmpty) {
      return;
    }
    if (type == null || type.isEmpty) {
      return;
    }

    if (condition == null || condition.isEmpty) {
      return;
    }
    if (type == "Add To Sell") {
      if (sell_type == null ||
          sell_type.isEmpty ||
          fully_boxed == null ||
          watchcondition == null) {
        return;
      }
      // if(sell_type=="")
      // if (trade_price.text.isEmpty || trade_price == null) {
      //   return;
      // }
    }
    var state = Provider.of<FeedState>(context, listen: false);
    kScreenloader.showLoader(context);

    watchModel watch = createwatchModel();

    /// If tweet contain image
    /// First image is uploaded on firebase storage
    /// After sucessfull image upload to firebase storage it returns image path
    /// Add this image path to tweet model and save to firebase database
    try {
      await state.uploadFile(_image).then((imagePath) {
        if (imagePath != null) {
          watch.imagePath = imagePath;

          /// If type of tweet is new tweet
          state.createWatch(watch);
        }
      });

      /// Checks for username in tweet description
      /// If foud sends notification to all tagged user
      /// If no user found or not compost tweet screen is closed and redirect back to home page.
      final composetweetstate =
          Provider.of<ComposeTweetState>(context, listen: false);
      final searchstate = Provider.of<SearchState>(context, listen: false);
      await composetweetstate
          .sendNotificationwatch(watch, searchstate)
          .then((_) {
        /// Hide running loader on screen
        kScreenloader.hideLoader();

        /// Navigate back to home page
        Navigator.pop(context);
      });
    } catch (e) {
      print(e);
      kScreenloader.hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AdminState>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Watch"),
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
                            : Image.asset("assets/placeholder-image.png",
                                height: 200, width: 200)),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropDown(
                      showUnderline: false,

                      items: state.brandnames,
                      // initialValue: user_customer_remainder_date.text,
                      hint: Text(
                        "Select Brand",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          brand.text = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),

                    child: GestureDetector(
                        onTap: () {
                          _addBrand(notifier);
                        },
                        child: Text("Enter new brand",textAlign:TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,),)),

                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropDown<watch_model_Model>(
                      showUnderline: false,
                      items: state.brandmodels
                          .where((element) =>
                              element.watch_brand ==
                              (brand.text == null || brand.text.isEmpty
                                  ? state.brandnames[0]
                                  : brand.text))
                          .toList(),
                      customWidgets: state.brandmodels
                          .where((element) =>
                              element.watch_brand ==
                              (brand.text == null || brand.text.isEmpty
                                  ? state.brandnames[0]
                                  : brand.text))
                          .toList()
                          .map((p) => buildDropDownRow(p))
                          .toList(),

                      // initialValue: user_customer_remainder_date.text,
                      hint: Text(
                        "Brand Model",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      onChanged: (watch_model_Model value) {
                        setState(() {
                          model_number.text = value.watch_model;
                        });
                      },
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),

                    child: GestureDetector(
                        onTap: () {

                          _addBrandModel(notifier);
                        },
                        child: Text("Enter new model",textAlign:TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,),)),

                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // WidgetAnimator(
              //   Padding(
              //     padding: const EdgeInsets.only(left: 28.0, right: 28),
              //     child: Container(
              //       width: 250,
              //       padding: EdgeInsets.all(4),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //             // set border color
              //             ), // set border width
              //         borderRadius: BorderRadius.all(
              //             Radius.circular(10.0)), // set rounded corner radius
              //       ),
              //       child: TextField(
              //         controller: brand,
              //         cursorColor:
              //             notifier.darkTheme ? Colors.white : Color(0xff151d3a),
              //         style: TextStyle(
              //             color: notifier.darkTheme
              //                 ? Colors.white
              //                 : Color(0xff151d3a)),
              //         decoration: InputDecoration(
              //           prefixText: "     ",
              //           hintStyle: TextStyle(
              //             color: notifier.darkTheme
              //                 ? Colors.white
              //                 : Color(0xff151d3a),
              //           ),
              //           hintText: 'Enter brand',
              //           border: InputBorder.none,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
                      keyboardType: TextInputType.numberWithOptions(),
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

              if (type == "Add To Sell")
                SizedBox(
                  height: 20,
                ),

              if (type == "Add To Sell")
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Sell Type',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),

              if (type == "Add To Sell")
                WidgetAnimator(
                  ListTile(
                    title: const Text('Sell'),
                    leading: Radio(
                      value: 1,
                      activeColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      groupValue: _radioValue3,
                      onChanged: (value) {
                        setState(() {
                          _radioValue3 = value;

                          sell_type = "sell";
                        });
                      },
                    ),
                  ),
                ),

              if (type == "Add To Sell")
                WidgetAnimator(
                  ListTile(
                    title: const Text('Trade'),
                    leading: Radio(
                      value: 2,
                      activeColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      groupValue: _radioValue3,
                      onChanged: (value) {
                        setState(() {
                          _radioValue3 = value;

                          sell_type = "trade";
                        });
                      },
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  ListTile(
                    title: const Text('Both'),
                    leading: Radio(
                      value: 3,
                      activeColor:
                      notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      groupValue: _radioValue3,
                      onChanged: (value) {
                        setState(() {
                          _radioValue3 = value;

                          sell_type = "both";
                        });
                      },
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Fully boxed with papers?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      activeColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      groupValue: _radioValue4,
                      onChanged: (value) {
                        setState(() {
                          _radioValue4 = value;

                          fully_boxed = true;
                        });
                      },
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 4,
                      activeColor:
                          notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      groupValue: _radioValue4,
                      onChanged: (value) {
                        setState(() {
                          _radioValue4 = value;

                          fully_boxed = false;
                        });
                      },
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                SizedBox(
                  height: 20,
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      sell_type == 'trade' ? 'Trade price' :sell_type=='sell'? 'Sales price':'Trade/Sell Price',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              if (type == "Add To Sell" && (sell_type=="both" || sell_type=="trade"))
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
                        controller: trade_price,
                        keyboardType: TextInputType.numberWithOptions(),
                        cursorColor: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a),
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
                          hintText: 'Trade price',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              if (type == "Add To Sell" && (sell_type=="both" || sell_type=="sell"))
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
                        controller: sales_price,
                        keyboardType: TextInputType.numberWithOptions(),
                        cursorColor: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a),
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
                          hintText:'Sales price',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                SizedBox(
                  height: 20,
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Watch Condition?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              if (type == "Add To Sell")
                WidgetAnimator(
                  RatingBar(
                    onRatingChanged: (rating) {
                      setState(() {
                        watchcondition = rating.toInt();
                      });
                    },
                    initialRating:
                        watchcondition == null ? 0 : watchcondition.toDouble(),
                    isHalfAllowed: true,
                    filledColor: Colors.amber,
                    halfFilledIcon: Icons.star_half,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
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
                        'Add Watch',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          );
        }));
  }

  Row buildDropDownRow(watch_model_Model model) {
    return Row(
      children: <Widget>[
        if (model.watch_brand == brand.text) Text(model.watch_model),
      ],
    );
  }

  _addBrand(notifier) async {
    await showDialog<String>(
      context: context,
        child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[

            Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
              child: new  TextField(
  controller: new_brand,
  cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
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
)
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('ADD'),
              onPressed: () {
if(new_brand.text!=null||new_brand.text.isNotEmpty) {
  final state = Provider.of<AdminState>(context,listen: false);
  state.addBrandNames(new_brand.text);
  brand.text=new_brand.text;
  Navigator.pop(context);
  new_brand.text="";
}

              })
        ],
      ),
    );
  }

  _addBrandModel(notifier) async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Column(
          children: <Widget>[

            Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: new  TextField(
                  controller: brand,
                  enabled: false,
                  cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
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
                )
            ),
            SizedBox(height: 30,),
            Container(
                width: MediaQuery.of(context).size.width*0.6,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    // set border color
                  ), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: new  TextField(
                  controller: new_model,
                  cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
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
                    hintText: 'Enter Model',
                    border: InputBorder.none,
                  ),
                )
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('ADD'),
              onPressed: () {
                if(new_model.text!=null||new_model.text.isNotEmpty) {
                  final state = Provider.of<AdminState>(context,listen: false);
                  state.addBrandModel(brand.text,new_model.text);
                  new_model.text="";
                  Navigator.pop(context);
                }
              })
        ],
      ),
    );
  }
}

// TextField(
//   controller: new_brand,
//   cursorColor:
//   notifier.darkTheme ? Colors.white : Color(0xff151d3a),
//   style: TextStyle(
//       color: notifier.darkTheme
//           ? Colors.white
//           : Color(0xff151d3a)),
//   decoration: InputDecoration(
//     prefixText: "     ",
//     hintStyle: TextStyle(
//       color: notifier.darkTheme
//           ? Colors.white
//           : Color(0xff151d3a),
//     ),
//     hintText: 'Enter brand',
//     border: InputBorder.none,
//   ),
// )
//