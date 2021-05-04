import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/chats/chatState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';
import 'package:provider/provider.dart';

import '../model/watchModel.dart';
import 'DummyData/dummy.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  TextEditingController editingController = new TextEditingController();


  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey=new GlobalKey<RefreshIndicatorState>();
  List<watchModel> list,list1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getdata(){
    var authstate = Provider.of<AuthState>(context,listen: false);
    var state = Provider.of<FeedState>(context,listen: false);
    setState(() {

      list = state.getWatches(
          authstate.userModel);
      list1=list;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    var authstate = Provider.of<AuthState>(context);
    var state = Provider.of<FeedState>(context,listen: false);

    // return Consumer<FeedState>(builder: (context, state, child) {
    //   final List<watchModel> list = state.getWatches(authstate.userModel);
    //   List<watchModel> list2;
    //   {

        return Scaffold(
          key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: primary,
              title: Text("Buy"),
            ),
            body: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: () async {

              final authstate = Provider.of<AuthState>(context,listen: false);
              /// refresh home page feed
              var feedState = Provider.of<FeedState>(context, listen: false);
              feedState.getFavouritesFromDatabase(authstate.userId);
              return Future.value(true);
              },
              child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        if(value.isNotEmpty) {
                          list = list
                              .where((x) =>
                          x.title != null &&
                              x.title.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        }
                        else{
                          list=list1;
                        }
                      });
                      print(list);
                    },
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),

                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                 Expanded(
                   child: ListView.builder(
                       itemCount: list==null?0:list.length,
                       itemBuilder: (context,index){
                         return WidgetAnimator(Padding(
                           padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                           child: GestureDetector(
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => WatchDetail(
                                 feed: list[index],
                               )));
                             },
                             child: Card(
                               elevation: 5,
                               child: ListTile(
                                 leading: Container(
                                     width: 60,
                                     height: 60,
                                     child: Image.network(list[index].imagePath)),
                                 title: Padding(
                                   padding: const EdgeInsets.only(top:8.0,left:8.0,right: 8.0),
                                   child: Text(list[index].title),
                                 ),
                                 subtitle: Container(
                                     height: 45,
                                     width: 300,
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(list[index].description),
                                     )),
                               ),
                             ),
                           ),
                         ));
                       }),
                 ),
              ],
            )));
     // }
    //});
  }
}
