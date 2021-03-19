import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';

class GiveAway extends StatefulWidget {
  @override
  _GiveAwayState createState() => _GiveAwayState();
}

class _GiveAwayState extends State<GiveAway> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Give Away"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetAnimator(
             Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/bg.png"),
              ),
            ),
            WidgetAnimator(Text("Take Part In Our Give Away",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            WidgetAnimator( Text("And Win Free Watches",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            WidgetAnimator(Text('Only For Registered Users',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(height: 20,),
            WidgetAnimator(
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("00",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("00",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("00",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("00",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            WidgetAnimator(
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all()
                      ),
                      child: Text("Days",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("Hours",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("Minutes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text("Seconds",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
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
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                  },
                  child: Text("Click To Take Part",style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
