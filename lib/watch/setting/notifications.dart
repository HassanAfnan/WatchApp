import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String,dynamic>> notifications =[
    {"title":"Notification1","message":"Lorem ipsum dolor sit amet consectetur adipiscing elit eros ante facilisis nec tempus, faucibus nascetur taciti dui pretium eu lobortis himenaeos mi interdum scelerisque. Justo himenaeos vitae tellus at fringilla nascetur pharetra per duis interdum, "},
    {"title":"Notification2","message":"Lorem ipsum dolor sit amet consectetur adipiscing elit eros ante facilisis nec tempus, faucibus nascetur taciti dui pretium eu lobortis himenaeos mi interdum scelerisque. Justo himenaeos vitae tellus at fringilla nascetur pharetra per duis interdum, "},
    {"title":"Notification2","message":"Lorem ipsum dolor sit amet consectetur adipiscing elit eros ante facilisis nec tempus, faucibus nascetur taciti dui pretium eu lobortis himenaeos mi interdum scelerisque. Justo himenaeos vitae tellus at fringilla nascetur pharetra per duis interdum, "},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context,index){
        return WidgetAnimator(
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(notifications[index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(notifications[index]['message']),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
