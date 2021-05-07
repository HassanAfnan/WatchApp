import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/model/blog_model.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:flutter_twitter_clone/watch/blog_detail.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  //const BlogPage({Key key, this.title, this.image, this.description}) : super(key: key);
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {

    final state = Provider.of<AdminState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: ListView.builder(
          itemCount: state.blogs ==null?0:state.blogs.length,
          itemBuilder: (context,index){
            return WidgetAnimator(Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(
                    title: state.blogs[index].title,
                    description: state.blogs[index].description,
                    image: state.blogs[index].image,
                  )));
                },
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Container(
                        width: 60,
                        height: 60,
                        child: Image.network(state.blogs[index].image)),
                    title: Padding(
                      padding: const EdgeInsets.only(top:8.0,left:8.0,right: 8.0),
                      child: Text(state.blogs[index].title),
                    ),
                    subtitle: Container(
                        height: 45,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.blogs[index].description),
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
