import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:flutter_twitter_clone/watch/wish_list.dart';

import 'DummyData/dummy.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Buy"),
        // actions: [
        //   Badge(
        //     position: BadgePosition(
        //       end: 2,
        //       top:5,
        //     ),
        //     badgeContent: Text('2',style: TextStyle(color: secondary),),
        //     child: IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){
        //       Navigator.push(context,MaterialPageRoute(builder: (context) => WishList()));
        //     }),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
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
      )
    );
  }
}
