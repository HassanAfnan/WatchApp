import 'dart:io';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/constant.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/model/feedModel.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/page/feed/feedPage.dart';
import 'package:flutter_twitter_clone/page/feed/feedPageFriends.dart';
import 'package:flutter_twitter_clone/page/message/chatListPage.dart';
import 'package:flutter_twitter_clone/page/profile/profilePage.dart';
import 'package:flutter_twitter_clone/page/search/SearchPage.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:flutter_twitter_clone/state/appState.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/chats/chatState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/state/notificationState.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:flutter_twitter_clone/watch/DummyData/dummy.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/Webview.dart';
import 'package:flutter_twitter_clone/watch/blog_page.dart';
import 'package:flutter_twitter_clone/watch/buy_screen.dart';
import 'package:flutter_twitter_clone/watch/contact.dart';
import 'package:flutter_twitter_clone/watch/makePayment.dart';
import 'package:flutter_twitter_clone/watch/mywatch_screen.dart';
import 'package:flutter_twitter_clone/watch/news.dart';
import 'package:flutter_twitter_clone/watch/sale_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/give_away.dart';
import 'package:flutter_twitter_clone/watch/setting/help.dart';
import 'package:flutter_twitter_clone/watch/setting/notifications.dart';
import 'package:flutter_twitter_clone/watch/setting/privacy.dart';
import 'package:flutter_twitter_clone/watch/setting/profile_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/rules.dart';
import 'package:flutter_twitter_clone/watch/setting/terms.dart';
import 'package:flutter_twitter_clone/watch/setting/terms_conditions.dart';
import 'package:flutter_twitter_clone/watch/settings.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/watch/spash_screen.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loader = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<AppState>(context, listen: false);
      state.setpageIndex = 0;

      initProfile();
      initSearch();
      initNotification();
      initChat();
      initAdminSettings();
      initTweets();
    });
    // TODO: implement initState
    super.initState();
  }

  void initTweets() {

    final authstate = Provider.of<AuthState>(context, listen: false);
    var state = Provider.of<FeedState>(context, listen: false);
    state.databaseInit();
    state.getDataFromDatabase();
    state.getwatchDataFromDatabase();
    state.getNewsFromDatabase();
    state.getFavouritesFromDatabase(authstate.user.uid);
  }

  List<NetworkImage> _sliders;

  void initAdminSettings() async {
    setState(() {
      loader = true;
    });
    _sliders = List<NetworkImage>();
    final state = Provider.of<AdminState>(context, listen: false);
    await state.getslidersfromdatabase();
    await state.getterms_and_condition();
    await state.getFaqs();
    state.getBrandNames();
    state.getBrandModels();
    state.getNotification();
    state.getContestSetting();
    state.getContestUsers();
    for (int i = 0; i < state.sliders.length; i++) {
      setState(() {
        _sliders.add(NetworkImage(state.sliders[i].slider_url));
      });
      if (i == state.sliders.length - 1) {
        setState(() {
          loader = false;
        });
      }
    }
  }

  void initProfile() {
    var state = Provider.of<AuthState>(context, listen: false);
    state.databaseInit();
  }

  void initSearch() {
    var searchState = Provider.of<SearchState>(context, listen: false);
    searchState.getDataFromDatabase();
  }

  void initNotification() {
    var state = Provider.of<NotificationState>(context, listen: false);
    var authstate = Provider.of<AuthState>(context, listen: false);
    state.databaseInit(authstate.userId);
    state.initfirebaseService();
  }

  void initChat() {
    final chatState = Provider.of<ChatState>(context, listen: false);
    final state = Provider.of<AuthState>(context, listen: false);
    chatState.databaseInit(state.userId, state.userId);

    /// It will update fcm token in database
    /// fcm token is required to send firebase notification
    state.updateFCMToken();

    /// It get fcm server key
    /// Server key is required to configure firebase notification
    /// Without fcm server notification can not be sent
    chatState.getFCMServerKey();
  }

  @override
  Widget build(BuildContext context) {
    var authstate = Provider.of<AuthState>(context);

    final adminstate = Provider.of<AdminState>(context, listen: false);
    return Consumer<FeedState>(builder: (context, state, child) {
      final List<watchModel> list = state.getWatches(authstate.userModel);

      return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          centerTitle: true,
          backgroundColor: primary,
          title: Text('Elite Edge Ware'),
          actions: [
            // Badge(
            //   position: BadgePosition(
            //     end: 2,
            //     top:5,
            //   ),
            //   badgeContent: Text('2',style: TextStyle(color: secondary),),
            //   child: IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context) => WishList()));
            //   }),
            // ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Elite Edge Ware"),
                    content: Text("Do you want to logout?"),
                    actions: [
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {

                          authstate.logoutCallback();
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(builder: (context) => WatchSplashScreen()),
                          //     (Route<dynamic> route) => false);
                          exit(0);
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: () async {
            /// refresh home page feed
            var feedState = Provider.of<FeedState>(context, listen: false);
            feedState.getDataFromDatabase();
            return Future.value(true);
          },
          child: Column(
            children: [
              loader
                  ? SpinKitRipple(
                      color: Colors.white,
                      size: 40,
                    )
                  : WidgetAnimator(
                  new Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
              options: CarouselOptions(
                //aspectRatio: 16/9,
                //viewportFraction: 0.8,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: adminstate.sliders.map((item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WebViewExample(url: item.link_url,)));
                },
                child: Image.network(item.slider_url,fit: BoxFit.fill,height: 300,width: MediaQuery.of(context).size.width),
              )).toList(),
            )
        ),
//                       child: new Carousel(
//                         boxFit: BoxFit.cover,
//                         images: _sliders,
//                         autoplay: true,
//                         animationCurve: Curves.fastOutSlowIn,
//                         animationDuration: Duration(milliseconds: 1000),
//                         dotColor: secondary,
// //        dotSize: 4.0,
// //        indicatorBgPadding: 2.0,
//                       ),
                    ),
              SizedBox(
                height: 10.0,
              ),
              WidgetAnimator(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => FeedPage()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top:28.0,bottom: 28.0),
                            child: Text("Advert Reel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              WidgetAnimator(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => BuyScreen()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top:28.0,bottom: 28.0),
                            child: Text("Buy/Sale/Trade",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              WidgetAnimator(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => BlogPage()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top:28.0,bottom: 28.0),
                            child: Text("Blog Reel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              WidgetAnimator(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => NewsScreen()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(top:28.0,bottom: 28.0),
                            child: Text("News Reel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),)
              // Expanded(
              //   child: GridView.builder(
              //     primary: false,
              //     itemCount: list == null ? 0 : list.length,
              //     itemBuilder: (cyx, index) {
              //
              //       return WidgetAnimator(Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(20),
              //           child: GridTile(
              //             child: GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) => WatchDetail(
              //                             feed: list[index],
              //                               )));
              //                 },
              //                 child: Hero(
              //                   tag:list[index].key,
              //                   child: FadeInImage(
              //                     placeholder: NetworkImage(list[index].imagePath),
              //                     image: NetworkImage(list[index].imagePath),
              //                     fit: BoxFit.cover,
              //                   ),
              //                 )),
              //             footer: GridTileBar(
              //               backgroundColor: Colors.black87,
              //               leading: IconButton(
              //                 icon: Icon(
              //                   state.favouriteslist==null?Icons.favorite_border:state.favouriteslist.indexWhere((element) => element.key==list[index].key)>=0?Icons.favorite:Icons.favorite_border,
              //                   color: Colors.red,
              //                 ),
              //                 onPressed: () {
              //                   if(  state.favouriteslist.indexWhere((element) => element.key==list[index].key)>=0){
              //
              //                     state.removeFromFavourites(authstate.userId, list[index].key,list[index]);
              //
              //                   }
              //                 else {
              //                   try {
              //                     state.createFavourite(
              //                         list[index], authstate.userId);
              //                     customSnackBar(_scaffoldKey,"Added to your wishlist");
              //                   }
              //                   catch(e){print(e);}
              //                 }
              //                 },
              //               ),
              //               trailing: IconButton(
              //                 icon: Icon(
              //                   Icons.chat,
              //                   color: Theme.of(context).accentColor,
              //                 ),
              //                 onPressed: () {
              //
              //                   final chatState = Provider.of<ChatState>(context, listen: false);
              //                   chatState.setChatUser = list[index].user;
              //                   Navigator.pushNamed(context, '/ChatScreenPage');
              //                 },
              //               ),
              //               title: Text(
              //                 list[index].title,
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(fontSize: 7,fontWeight: FontWeight.w900),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ));
              //     },
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 10
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        drawer: Consumer<ThemeNotifier>(
          builder: (context, notifier, value) {
            return Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountEmail: Text(
                      authstate.userModel.email,
                      style: TextStyle(color: secondary),
                    ),
                    accountName: Text(
                      authstate.userModel.displayName,
                      style: TextStyle(color: secondary),
                    ),
                    currentAccountPicture: GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => new Profile()));
                      },
                      child: new CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 100,
                        child: ClipOval(
                          child: Image.network(authstate.userModel.profilePic,
                              width: 150, height: 150, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  // body

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(Icons.home,
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                  ),

                  InkWell(
                    onTap: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new FeedPage(scaffoldKey: _scaffoldKey)));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => new EventPage(
                      //   type: "user",
                      // )));
                    },
                    child: ListTile(
                      title: Text(
                        'Lounge',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(Icons.camera,
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if(authstate.userModel.isSubscribed) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                new FeedPageFriends(
                                    scaffoldKey: _scaffoldKey)));
                      }
                      else{

                        SweetAlert.show(context,
                            title: "Subscription",
                            subtitle: "Please subscribe to have full access to Elite Edgeware",
                            style: SweetAlertStyle.confirm,
                            confirmButtonText: "Subscribe",
                            showCancelButton: true, onPress: (bool isConfirm) {
                              if (isConfirm) {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            makePayment(cost: "11.99",)));
                                //SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                // return false to keep dialog
                                return false;
                              }
                            });
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => new EventPage(
                      //   type: "user",
                      // )));
                    },
                    child: ListTile(
                      title: Text(
                        "Watch Buddy's Lobby",
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),

                      leading: Icon(Icons.contacts,
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if(authstate.userModel.isSubscribed) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new BuyScreen()));
                      }
                      else{

                        SweetAlert.show(context,
                            title: "Subscription",
                            subtitle: "Please subscribe to have full access to Elite Edgeware",
                            style: SweetAlertStyle.confirm,
                            confirmButtonText: "Subscribe",
                            showCancelButton: true, onPress: (bool isConfirm) {
                              if (isConfirm) {
                                //SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                // return false to keep dialog
                                return false;
                              }
                            });
                      }
                    },
                    child: ListTile(
                      title: Text(
                        'Buy',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(Icons.shop_outlined,
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      if(authstate.userModel.isSubscribed) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaleScreen()));
                      } else{

                        SweetAlert.show(context,
                            title: "Subscription",
                            subtitle: "Please subscribe to have full access to Elite Edgeware",
                            style: SweetAlertStyle.confirm,
                            confirmButtonText: "Subscribe",
                            showCancelButton: true, onPress: (bool isConfirm) {
                              if (isConfirm) {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            makePayment(cost: "11.99",)));
                                //SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                // return false to keep dialog
                                return false;
                              }
                            });
                      }
                    },
                    child: ListTile(
                      title: Text(
                        'Sell/Trade',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.monetization_on,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new NewsScreen()));
                    },
                    child: ListTile(
                      title: Text(
                        'News',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.location_on,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyWatch()));
                    },
                    child: ListTile(
                      title: Text(
                        'My Watch Box',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.watch_outlined,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WishList()));
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => new NamazTiming()));
                    },
                    child: ListTile(
                      title: Text(
                        'Wish List',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.shopping_cart,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    child: ListTile(
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.person_rounded,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      if(authstate.userModel.isSubscribed) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => GiveAway()));
                      } else{

                        SweetAlert.show(context,
                            title: "Subscription",
                            subtitle: "Please subscribe to have full access to Elite Edgeware",
                            style: SweetAlertStyle.confirm,
                            confirmButtonText: "Subscribe",
                            showCancelButton: true, onPress: (bool isConfirm) {
                              if (isConfirm) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            makePayment(cost: "11.99",)));
                                //SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                // return false to keep dialog
                                return false;
                              }
                            });
                      }
                    },
                    child: ListTile(
                      title: Text(
                        'Give Away',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.card_giftcard,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  Divider(
                    color: notifier.darkTheme ? Colors.white : primary,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Contact()));
                    },
                    child: ListTile(
                      title: Text(
                        'Contact Us',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(Icons.mail,
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      //
                      // final chatState = Provider.of<ChatState>(context, listen: false);
                      // chatState.setChatUser = widget.feed.user;
                      //Navigator.pushNamed(context, '/ChatListPage');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage(scaffoldKey: _scaffoldKey)));
                    },
                    child: ListTile(
                      title: Text(
                        'Message',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.message,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()));
                    },
                    child: ListTile(
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.notifications,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      if(authstate.userModel.isSubscribed){


                        SweetAlert.show(context,
                            title: "Subscribed",
                            subtitle: "You are already subscribed",
                            style: SweetAlertStyle.confirm,
                            confirmButtonText: "Ok",

                            showCancelButton: false, onPress: (bool isConfirm) {
                              if (isConfirm) {
                                Navigator.pop(context);
                                //SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                // return false to keep dialog
                                return false;
                              }
                            });

                      }
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    makePayment(cost: "11.99",)));
                      }
                      },
                    child: ListTile(
                      title: Text(
                        'Subscriptions',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.subscriptions,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Help()));
                    },
                    child: ListTile(
                      title: Text(
                        'Help',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.help,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TermsAndConditions()));
                    },
                    child: ListTile(
                      title: Text(
                        'Terms and conditions',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.indeterminate_check_box_rounded,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Privacy()));
                    },
                    child: ListTile(
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.privacy_tip,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),   InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Rules()));
                    },
                    child: ListTile(
                      title: Text(
                        'Giveaway Rules',
                        style: TextStyle(
                            color: notifier.darkTheme ? Colors.white : primary),
                      ),
                      leading: Icon(
                        Icons.privacy_tip,
                        color: notifier.darkTheme ? Colors.white : primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
