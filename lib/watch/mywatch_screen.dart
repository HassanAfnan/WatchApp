import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/watch/add_watch.dart';
import 'package:flutter_twitter_clone/watch/update_watch.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

import 'DummyData/dummy.dart';
class MyWatch extends StatefulWidget {
  @override
  _MyWatchState createState() => _MyWatchState();
}

class _MyWatchState extends State<MyWatch> {

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey=new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    var authstate = Provider.of<AuthState>(context);

    return Consumer<FeedState>(builder: (context, state, child)
    {
      final List<watchModel> list = state.getmyWatches(authstate.userModel);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Watch Box"),
        ),
        body:
        RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () async {

        final authstate = Provider.of<AuthState>(context,listen: false);
        /// refresh home page feed
        var feedState = Provider.of<FeedState>(context, listen: false);
        feedState.getFavouritesFromDatabase(authstate.userId);
        return Future.value(true);
        },
        child:
        Column(
          children: [
            Expanded(
              child: GridView.builder(
                primary: false,
                itemCount: list==null?0:list.length,
                itemBuilder: (cyx, index) {
                  return WidgetAnimator(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GridTile(
                            child: GestureDetector(
                                onTap: () {


                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>UpdateWatch(watch: list[index],)));
                                },
                                child: Hero(
                                  tag: list[index].key,
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
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {


                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>UpdateWatch(watch: list[index],)));
                                },),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete, color: Colors.red,
                                ),
                                onPressed: () {

                                  SweetAlert.show(context,
                                      title: "Delete",
                                      subtitle: "Are you sure you want to delete this?",
                                      style: SweetAlertStyle.confirm,
                                      showCancelButton: true, onPress: (bool isConfirm) {
                                        if (isConfirm) {
                                          state.deleteWatch(list[index]);
                                          SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                          // return false to keep dialog
                                          return false;
                                        }
                                      });
                                },),
                              title: Text(list[index].title,
                                textAlign: TextAlign.center,),
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
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddWatch()));
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add, color: Colors.white,),
        ),
      );
    });
  }
}
