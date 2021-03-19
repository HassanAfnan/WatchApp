import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/watch_detail.dart';
import 'package:provider/provider.dart';

import 'DummyData/dummy.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  double cart = 160.00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wish List"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return GridView.builder(
            primary: false,
            itemCount: wishList.length,
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
                                id: wishList[index].id,
                                brand: wishList[index].brand,
                                description: wishList[index].description,
                                rating: wishList[index].rating,
                                image: wishList[index].image,
                                price: wishList[index].price,
                              )));
                            },
                            child: Hero(
                              tag: wishList[index].id,
                              child: FadeInImage(
                                placeholder: AssetImage('assets/placeholder-image.png'),
                                image: NetworkImage(wishList[index].image),
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
                            onPressed: (){},),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.chat,color: Theme.of(context).accentColor,
                            ),
                            onPressed: (){
                            },),
                          title: Text(wishList[index].brand,textAlign: TextAlign.center,),
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
          );
        },
      )
    );
  }
}
