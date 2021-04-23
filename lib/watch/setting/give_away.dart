import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/animations/bottomAnimation.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/state/adminState.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class GiveAway extends StatefulWidget {
  @override
  _GiveAwayState createState() => _GiveAwayState();
}

class _GiveAwayState extends State<GiveAway> {

  @override
  Widget build(BuildContext context) {

    final state = Provider.of<AdminState>(context);

    final authstate = Provider.of<AuthState>(context);
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
            WidgetAnimator(Text('Valid Till',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

            WidgetAnimator(
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: Text(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(state.contestdate)),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
                  color: state.enablecontest?primary:Colors.green,
                  onPressed: (){
                    if(state.enablecontest) {
                      if (state.contestusers.indexWhere((element) =>
                      element.userId == authstate.userModel.userId) >= 0) {}
                      else {
                        state.registeredContest(authstate.userModel);
                        SweetAlert.show(context,
                            title: "Success",
                            subtitle: "Successfully Registered",
                            style: SweetAlertStyle.success);
                      }
                    }
                    else{

                    }

                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                  },
                  child: Text(state.contestusers.indexWhere((element) => element.userId==authstate.userModel.userId)>=0?"Already Registered":"Click To Take Part",style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
