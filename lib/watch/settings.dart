import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/page/message/chatListPage.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/setting/give_away.dart';
import 'package:flutter_twitter_clone/watch/setting/help.dart';
import 'package:flutter_twitter_clone/watch/setting/notifications.dart';
import 'package:flutter_twitter_clone/watch/setting/profile_screen.dart';
import 'package:flutter_twitter_clone/watch/setting/terms.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  List<String> options = [
    "Profile",
    "Notifications",
    "Message",
    "Give Away",
    "Referral Share",
    "Help",
    "Terms And Conditions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Settings",style: TextStyle(color: secondary),),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return ListView.builder(
              itemCount: options.length,
              itemBuilder: (context,index){
                return WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
                        if(options[index] == "Profile"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                        }
                        else if(options[index] == "Terms And Conditions"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Terms()));
                        }
                        else if(options[index] == "Message"){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage()));
                        }
                        else if(options[index] == "Help"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
                        }
                        else if(options[index]== "Notifications"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
                        }
                        else if(options[index] == "Give Away"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GiveAway()));
                        }
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(options[index],style:TextStyle(fontSize: 16,color: notifier.darkTheme ? Colors.white :primary,)),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
