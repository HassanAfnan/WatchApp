import 'dart:io';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
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
import 'package:flutter_twitter_clone/watch/buy_screen.dart';
import 'package:flutter_twitter_clone/watch/contact.dart';
import 'package:flutter_twitter_clone/watch/mywatch_screen.dart';
import 'package:flutter_twitter_clone/watch/news.dart';
import 'package:flutter_twitter_clone/watch/sale_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/give_away.dart';
import 'package:flutter_twitter_clone/watch/setting/help.dart';
import 'package:flutter_twitter_clone/watch/setting/notifications.dart';
import 'package:flutter_twitter_clone/watch/setting/privacy.dart';
import 'package:flutter_twitter_clone/watch/setting/profile_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/terms.dart';
import 'package:flutter_twitter_clone/watch/setting/terms_conditions.dart';
import 'package:flutter_twitter_clone/watch/settings.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:provider/provider.dart';

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
    state.getContestUsers();
    for (int i = 0; i < state.sliders.length; i++) {
      setState(() {
        _sliders.add(NetworkImage(state.sliders[i]));
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
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false);
                         // exit(0);
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
                  : WidgetAnimator(new Container(
                      height: 200.0,
                      child: new Carousel(
                        boxFit: BoxFit.cover,
                        images: _sliders,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1000),
                        dotColor: secondary,
//        dotSize: 4.0,
//        indicatorBgPadding: 2.0,
                      ),
                    )),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: GridView.builder(
                  primary: false,
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (cyx, index) {

                    return WidgetAnimator(Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GridTile(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WatchDetail(
                                          feed: list[index],
                                            )));
                              },
                              child: Hero(
                                tag:list[index].key,
                                child: FadeInImage(
                                  placeholder: NetworkImage(list[index].imagePath),
                                  image: NetworkImage(list[index].imagePath),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          footer: GridTileBar(
                            backgroundColor: Colors.black87,
                            leading: IconButton(
                              icon: Icon(
                                state.favouriteslist.indexWhere((element) => element.key==list[index].key)>=0?Icons.favorite:Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                if(  state.favouriteslist.indexWhere((element) => element.key==list[index].key)>=0){

                                  state.removeFromFavourites(authstate.userId, list[index].key,list[index]);

                                }
                              else {
                                try {
                                  state.createFavourite(
                                      list[index], authstate.userId);
                                  customSnackBar(_scaffoldKey,"Added to your wishlist");
                                }
                                catch(e){print(e);}
                              }
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.chat,
                                color: Theme.of(context).accentColor,
                              ),
                              onPressed: () {

                                final chatState = Provider.of<ChatState>(context, listen: false);
                                chatState.setChatUser = list[index].user;
                                Navigator.pushNamed(context, '/ChatScreenPage');
                              },
                            ),
                            title: Text(
                              list[index].title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                ),
              ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              new FeedPageFriends(scaffoldKey: _scaffoldKey)));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new BuyScreen()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SaleScreen()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GiveAway()));
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
