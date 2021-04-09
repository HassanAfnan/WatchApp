import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/feedModel.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/chats/chatState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

class WatchDetail extends StatefulWidget {
final watchModel feed;

  const WatchDetail({Key key, this.feed}) : super(key: key);
  @override
  _WatchDetailState createState() => _WatchDetailState();
}

class _WatchDetailState extends State<WatchDetail> {
  int quantity = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget image_coursel = new Container(
    height: 200.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/p1.jpeg'),
        AssetImage('assets/p2.jpeg'),
        AssetImage('assets/p3.jpeg'),
        AssetImage('assets/p4.jpeg'),
        AssetImage('assets/p5.jpeg'),
        AssetImage('assets/p6.jpeg'),
        AssetImage('assets/p7.jpeg'),
      ],
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
      dotColor: secondary,
//        dotSize: 4.0,
//        indicatorBgPadding: 2.0,
    ),
  );
  CustomLoader loader;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loader = CustomLoader();
  }
  @override
  Widget build(BuildContext context) {
    var authstate = Provider.of<AuthState>(context, listen: false);
    var feedState = Provider.of<FeedState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Watch Detail"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Hero(
                    tag: widget.feed.userId,
                    child: Image.network(
                      widget.feed.imagePath,
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                WidgetAnimator(Text("\£ "+widget.feed.sales_price==null?"":widget.feed.sales_price,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25),)),
                SizedBox(height: 10,),
                WidgetAnimator(Text( widget.feed.title,style: TextStyle(color: notifier.darkTheme ? Colors.white : primary,fontWeight: FontWeight.bold,fontSize: 20),)),
                SizedBox(height: 10,),
                WidgetAnimator(
                  RatingBar.readOnly(
                    initialRating: double.parse(widget.feed.watch_condition.toString()),
                    isHalfAllowed: true,
                    filledColor: Colors.amber,
                    halfFilledIcon: Icons.star_half,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 400,
                      child: Text( widget.feed.description,style: TextStyle(fontSize: 16,color: notifier.darkTheme ? Colors.white :primary),),
                    ),
                  ),
                ),
                // WidgetAnimator(
                //     Padding(
                //       padding: const EdgeInsets.only(left:8.0,right: 8.0),
                //       child: Card(
                //         elevation: 5,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 IconButton(icon: Icon(Icons.add_circle,color: Colors.green,), onPressed: (){
                //                   setState(() {
                //                     quantity++;
                //                   });
                //                 }),
                //                 Card(
                //                   elevation: 2,
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                //                     child: Container(
                //                         child: Text(quantity.toString(),style: TextStyle(color: notifier.darkTheme ? Colors.white :primary,fontWeight: FontWeight.bold),)),
                //                   ),
                //                 ),
                //                 IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,), onPressed: (){
                //                   setState(() {
                //                     if(quantity == 1){
                //                       print("Quantity");
                //                     }else{
                //                       quantity--;
                //                     }
                //                   });
                //                 }),
                //               ],
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(right:30.0),
                //               child: Text("\$ "+total.toStringAsFixed(2),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25),),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                // ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetAnimator(
                          FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              color: Colors.red,
                              onPressed: (){

                                final chatState = Provider.of<ChatState>(context, listen: false);
                                chatState.setChatUser = widget.feed.user;
                                Navigator.pushNamed(context, '/ChatScreenPage');

                              }, icon: Icon(Icons.chat,color: Colors.white,), label: Text("Start Chat",style: TextStyle(color: Colors.white),)),
                        ),
                        SizedBox(width: 20,),
                        WidgetAnimator(
                          FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              color: Colors.green,
                              onPressed: (){
                                if(feedState.favouriteslist.contains(widget.feed)){}
                                else {
                                  try {
                                    feedState.createFavourite(
                                        widget.feed, authstate.userId);
                                  customSnackBar(_scaffoldKey,"Added to your wishlist");
                                  }
                                  catch(e){}
                                }
                              }, icon: Icon(Icons.favorite_border,color: Colors.white,), label: Text("Add To Favourite",style: TextStyle(color: Colors.white),)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }

//   addtofav(){
//     // if (name.text == null ||
//     //     name.text.isEmpty ||
//     //     email.text == null ||
//     //     email.text.isEmpty ||
//     //     comment.text == null||comment.text.isEmpty) {
//     //   customSnackBar(_scaffoldKey, 'Please fill form carefully');
//     //   return;
//     // }
//
//     loader.showLoader(context);
//     try {
// FeedModel feed=widget.feed;
// String favId=DateTime.now().millisecondsSinceEpoch.toString();
// feed.favId=favId;
//       kDatabase.child('favourites').child(authstate.userId).child(favId).set(widget.feed.toJson());
//       loader.hideLoader();
//       Flushbar(
//         flushbarPosition: FlushbarPosition.TOP,
//         title: "Success",
//         message: "This watch is added in your favourites list",
//         duration: Duration(seconds: 3),)
//         ..show(context);
//       setState(() {
//       });
//
//     }
//     catch(e){
//       loader.hideLoader();
//       customSnackBar(_scaffoldKey, 'Error adding this product to Favourites.Try later');
//
//     }
//   }
}
