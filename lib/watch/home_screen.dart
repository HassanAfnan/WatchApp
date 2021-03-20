import 'dart:io';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
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
import 'package:flutter_twitter_clone/watch/setting/profile_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/terms.dart';
import 'package:flutter_twitter_clone/watch/settings.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Elite Edge Ware"),
                content: Text("Do you want to logout?"),
                actions: [
                  FlatButton(
                    child: Text("Yes"),
                    onPressed:  (){
                      exit(0);
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed:  () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            );
          },),
        ],
      ),
      body: Column(
        children: [
          WidgetAnimator(image_coursel),
          SizedBox(height: 10.0,),
          Expanded(
            child: GridView.builder(
              primary: false,
              itemCount: watches.length,
              itemBuilder:(cyx,index){
                return WidgetAnimator(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GridTile(
                          child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WatchDetail(
                                    id: watches[index].id,
                                    brand: watches[index].brand,
                                    description: watches[index].description,
                                    rating: watches[index].rating,
                                    image: watches[index].image,
                                    price: watches[index].price,
                                )));
                              },
                              child: Hero(
                                tag: watches[index].id,
                                child: FadeInImage(
                                  placeholder: AssetImage('assets/placeholder-image.png'),
                                  image: NetworkImage(watches[index].image),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          footer: GridTileBar(
                            backgroundColor: Colors.black87,
                            leading: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: (){},),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.chat,color: Theme.of(context).accentColor,
                              ),
                              onPressed: (){
                              },),
                            title: Text(watches[index].brand,textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    )
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
            ),
          ),
        ],
      ),
      drawer: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountEmail: Text("User Email",style: TextStyle(color: secondary),),
                  accountName: Text("Username",style: TextStyle(color: secondary),),
                  currentAccountPicture: GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => new Profile()));
                    },
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child: ClipOval(
                        child: Image.network(
                            "https://www.w3schools.com/howto/img_avatar.png",
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover
                        ),
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
                    title: Text('Home',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.home, color: notifier.darkTheme ? Colors.white :primary),
                  ),
                ),

                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => new EventPage(
                    //   type: "user",
                    // )));
                  },
                  child: ListTile(
                    title: Text('Lounge',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.camera, color: notifier.darkTheme ? Colors.white :primary),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new BuyScreen()));
                  },
                  child: ListTile(
                    title: Text('Buy',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.shop_outlined, color: notifier.darkTheme ? Colors.white :primary),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SaleScreen()));
                  },
                  child: ListTile(
                    title: Text('Sell/Trade',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.monetization_on, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => new NewsScreen()));
                  },
                  child: ListTile(
                    title: Text('News',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.location_on, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyWatch()));
                  },
                  child: ListTile(
                    title: Text('My Watch Box',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.watch_outlined, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => WishList()));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => new NamazTiming()));
                  },
                  child: ListTile(
                    title: Text('Wish List',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.shopping_cart, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
                  child: ListTile(
                    title: Text('Profile',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.person_rounded, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GiveAway()));
                  },
                  child: ListTile(
                    title: Text('Give Away',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.card_giftcard, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                Divider(
                  color: notifier.darkTheme ? Colors.white :primary,
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                  },
                  child: ListTile(
                    title: Text('Contact Us',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.mail, color: notifier.darkTheme ? Colors.white :primary),
                  ),
                ),

                InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => GiveAway()));
                  },
                  child: ListTile(
                    title: Text('Message',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.message, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
                  },
                  child: ListTile(
                    title: Text('Notifications',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.notifications, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
                  },
                  child: ListTile(
                    title: Text('Help',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.help, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Terms()));
                  },
                  child: ListTile(
                    title: Text('Terms and conditions',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.indeterminate_check_box_rounded, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
