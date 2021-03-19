import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/watch/add_watch.dart';

import 'DummyData/dummy.dart';
class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sell / Trade"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              primary: false,
              itemCount: saleWatches.length,
              itemBuilder:(cyx,index){
                return WidgetAnimator(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GridTile(
                          child: GestureDetector(
                              onTap: (){
                              },
                              child: Hero(
                                tag: saleWatches[index].id,
                                child: FadeInImage(
                                  placeholder: AssetImage('assets/placeholder-image.png'),
                                  image: NetworkImage(saleWatches[index].image),
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
                              onPressed: (){},),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,color: Colors.red,
                              ),
                              onPressed: (){
                              },),
                            title: Text(saleWatches[index].brand,textAlign: TextAlign.center,),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Navigator.push(context,MaterialPageRoute(builder: (context) => AddWatch()));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
