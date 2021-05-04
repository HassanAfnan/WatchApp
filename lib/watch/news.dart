import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/state/feedState.dart';
import 'package:flutter_twitter_clone/watch/DummyData/dummy.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  Widget build(BuildContext context) {

    var state = Provider.of<FeedState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News"),
      ),
      body: ListView.builder(
          itemCount: state.newslist==null?0:state.newslist.length,
          itemBuilder: (context,index){
            return WidgetAnimator(Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
              child: Card(
                elevation: 5,
                child: ListTile(
                  leading: Container(
                      width: 60,
                      height: 60,
                      child: Image.network(state.newslist[index].image)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:8.0,left:8.0,right: 8.0),
                    child: Text(state.newslist[index].title),
                  ),
                  subtitle: Container(
                      height: 45,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.newslist[index].description),
                      )),
                ),
              ),
            ));
            // return Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(20))
            //     ),
            //     elevation: 5,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         ClipRRect(
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(20),
            //               topRight: Radius.circular(20)
            //             ),
            //             child: Image.network(state.newslist[index].image,height: 120,width:400,fit: BoxFit.cover,)),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(state.newslist[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(state.newslist[index].description),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }
      ),
    );
  }
}
