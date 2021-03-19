import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/watch/contact.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Help Center"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          WidgetAnimator(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem Ipsem?",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit integer, ornare condimentum non habitasse iaculis elementum etiam ut aptent, lacinia ridiculus aenean est volutpat mauris praesent."),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem Ipsem?",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit integer, ornare condimentum non habitasse iaculis elementum etiam ut aptent, lacinia ridiculus aenean est volutpat mauris praesent."),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem Ipsem?",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Lorem ipsum dolor sit amet consectetur adipiscing elit integer, ornare condimentum non habitasse iaculis elementum etiam ut aptent, lacinia ridiculus aenean est volutpat mauris praesent."),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          WidgetAnimator(
            Padding(
              padding: const EdgeInsets.only(left:50.0,right: 50.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  color: primary,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                  },
                  child: Text("Contact",style: TextStyle(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
