import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/chats/chatState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:provider/provider.dart';

import 'DummyData/dummy.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  double cart = 160.00;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey=new GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    var state = Provider.of<FeedState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wish List"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return
            RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: () async {

                final authstate = Provider.of<AuthState>(context,listen: false);
                /// refresh home page feed
                var feedState = Provider.of<FeedState>(context, listen: false);
                feedState.getFavouritesFromDatabase(authstate.userId);
                return Future.value(true);
              },
              child:GridView.builder(
            primary: false,
            itemCount:state.favouriteslist==null?0:state.favouriteslist.length,
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
                             feed: state.favouriteslist[index],
                              )));
                            },
                            child: Hero(
                              tag: state.favouriteslist[index].key,
                              child: FadeInImage(
                                placeholder: NetworkImage(state.favouriteslist[index].imagePath),
                                image: NetworkImage(state.favouriteslist[index].imagePath),
                                fit: BoxFit.cover,
                              ),
                            )),
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: (){
                              state.removeFromFavourites(state.favouriteslist[index].userId, state.favouriteslist[index].key, state.favouriteslist[index]);

                              customSnackBar(_scaffoldKey,"Removed from wishlist");
                            },),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.chat,color: Theme.of(context).accentColor,
                            ),
                            onPressed: (){


                              final chatState = Provider.of<ChatState>(context, listen: false);
                              chatState.setChatUser = state.favouriteslist[index].user;
                              Navigator.pushNamed(context, '/ChatScreenPage');
                            },),
                          title: Text(state.favouriteslist[index].title,textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  )
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5/3,
                mainAxisSpacing: 10
            ),
          ));
        },
      )
    );
  }
}
