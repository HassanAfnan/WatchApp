import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final String title;
  final String image;
  final String description;

  const NewsDetail({Key key, this.title, this.image, this.description}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Detail"),
      ),
      body: ListView(
        children: [
          Image.network(widget.image),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(widget.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(widget.description),
          )
        ],
      ),
    );
  }
}
