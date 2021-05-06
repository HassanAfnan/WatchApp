import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/blog_detail.dart';
import 'package:flutter_twitter_clone/model/blog_model.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog"),
      ),
      body: ListView.builder(
          itemCount: blog ==null?0:blog.length,
          itemBuilder: (context,index){
            return WidgetAnimator(Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(
                    title: blog[index].title,
                    description: blog[index].description,
                    image: blog[index].image,
                  )));
                },
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                        width: 60,
                        height: 60,
                        child: Image.network(blog[index].image)),
                    title: Padding(
                      padding: const EdgeInsets.only(top:8.0,left:8.0,right: 8.0),
                      child: Text(blog[index].title),
                    ),
                    subtitle: Container(
                        height: 45,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(blog[index].description),
                        )),
                  ),
                ),
              ),
            ));
          }
      ),
    );
  }
}
