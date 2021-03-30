//
// import 'package:flutter_twitter_clone/helper/utility.dart';
// import 'package:flutter_twitter_clone/state/appState.dart';
//
// class AdminState extends AppState {
//

//
//
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/faq.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'appState.dart';

class AdminState extends AppState {
  List<String> _sliders=List<String>();
  String _terms_and_condition="";
  List<Faqs> _faqs=List<Faqs>();
  List<Map<String,dynamic>> _notifications=  List<Map<String,dynamic>>();
  String get terms_and_conditions{
    if(_terms_and_condition==null){
      return "";
    }
    else{
      return _terms_and_condition;
    }
  }
  List<Map<String,dynamic>> get notification{
    if(_notifications==null){

      return null;
    }
    else{

      return _notifications;
    }

  }
  List<String> get sliders {
    if (_sliders == null) {
      return null;
    } else {
      return _sliders;
    }
  }
  List<Faqs> get faqs{
    if(_faqs==null){

      return null;
    }
    else{

      return _faqs;
    }

  }
  getFaqs() async {
    var snapshot = await kDatabase.child('faqs').once();
    if (snapshot.value != null) {

      var map=snapshot.value;

      map.forEach((key, value) {
        Faqs temp=Faqs();
        temp.question=key;
        temp.answer=value;
        _faqs.add(temp);


      });
    } else {
      return null;
    }

  }
  getterms_and_condition() async{

    var snapshot = await kDatabase.child('terms_and_conditions').once();
    if (snapshot.value != null) {
      _terms_and_condition=(snapshot.value["text"]).toString();
    } else {
      return null;
    }
  }
  getslidersfromdatabase() async {
    var snapshot = await kDatabase.child('sliders').once();
    if (snapshot.value != null) {
      List<dynamic> slides = snapshot.value;
      for(int i=0;i<slides.length;i++){
            if(slides[i]!=null){
              _sliders.add(slides[i]);
            }
      }
    } else {
      return null;
    }


  }

}
