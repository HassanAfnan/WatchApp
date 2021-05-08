import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/model/blog_model.dart';
import 'package:flutter_twitter_clone/widgets/customWidgets.dart';

class BlogDetail extends StatefulWidget {
  final BlogModel blog;

  const BlogDetail({Key key, this.blog}) : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Detail"),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.blog.image,

            fit: BoxFit.fill,
        ),
           Container(
             width: MediaQuery.of(context).size.width * 0.5,
             child: Text(widget.blog.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(widget.blog.description),
          )
        ],
      ),
    );
  }
}
