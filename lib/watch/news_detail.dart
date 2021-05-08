import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/model/news_model.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel news;

  const NewsDetail({Key key, this.news}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.news.image
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(widget.news.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),

          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(widget.news.description),
          )
        ],
      ),
    );
  }
}
