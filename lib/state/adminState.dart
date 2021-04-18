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
import 'package:flutter_twitter_clone/model/notifications.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/model/watch_model_Model.dart';
import 'appState.dart';

class AdminState extends AppState {
  List<String> _sliders=List<String>();
  String _terms_and_condition="";
  List<Faqs> _faqs=List<Faqs>();
  List<Notifications> _notifications=List<Notifications>();
  String _termsconditionlink="";
  String _privacylink="";
  List<String> _brandnames=List<String>();
  List<UserModel> _contestusers=List<UserModel>();
  List<watch_model_Model> _brandmodel=new List<watch_model_Model>();

  List<Notifications> get notification{
    if(_notifications==null){

      return null;
    }
    else{

      return _notifications;
    }

  }
  List<UserModel> get contestusers{
    if(_contestusers==null){
      return null;
    }
    else{
      return _contestusers;
    }
  }
  String get terms_and_conditions{
    if(_terms_and_condition==null){
      return "";
    }
    else{
      return _terms_and_condition;
    }
  }

  List<watch_model_Model> get brandmodels{
    if(_brandmodel==null){
      return null;
  }
    else{
      return _brandmodel;
  }

}
  String get terms_link{
    if(_termsconditionlink==null){
      return "";
    }
    else{
      return _termsconditionlink;
    }
  }

  String get privacy_link{
    if(_privacylink==null){
      return "";
    }
    else{
      return _privacylink;
    }
  }

  getNotification() async {
    var snapshot = await kDatabase.child('notifications').once();
    if (snapshot.value != null) {

      var map=snapshot.value;

      map.forEach((key, value) {
        _notifications.add(Notifications.fromJson(value));


      });
    } else {
      return null;
    }
    notifyListeners();

  }

  getContestUsers() async {
    var snapshot = await kDatabase.child('contest').once();
    if (snapshot.value != null) {

      var map=snapshot.value;

      map.forEach((key, value) {
        _contestusers.add(UserModel.fromJson(value));


      });
    } else {
      return null;
    }
    notifyListeners();

  }
  List<String> get sliders {
    if (_sliders == null) {
      return null;
    } else {
      return _sliders;
    }
  }
  List<String> get brandnames {
    if (_brandnames == null) {
      return null;
    } else {
      return _brandnames;
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

      _termsconditionlink=(snapshot.value["pdf_url"]).toString();

      _privacylink=(snapshot.value["privacy_url"]).toString();
    } else {
      return null;
    }
  }
  getBrandNames() async {
    var snapshot = await kDatabase.child('watchbrands').once();
    if (snapshot.value != null) {

      List<dynamic> brands = snapshot.value;
      for(int i=0;i<brands.length;i++){
        if(brands[i]!=null){
          _brandnames.add(brands[i].toString().toUpperCase());
        }
      }
    } else {
      return null;
    }

  }
  addBrandNames(String brandname) async {
try {
  kDatabase.child('watchbrands').update({
    (_brandnames.length+1).toString():brandname
  });
  _brandnames.add(brandname.toUpperCase());
  notifyListeners();
}
catch(e){
  print(e);
}
  }
  addBrandModel(String brandname,String modelnumber) async {
    try {
watch_model_Model watch=watch_model_Model();
watch.watch_model=modelnumber;
watch.watch_brand=brandname.toUpperCase();
watch.watch_model_description="Oyster, 41 mm, Oystersteel";

String key=DateTime.now().millisecondsSinceEpoch.toString();
      kDatabase.child('watchmodels').child(brandname).child(key).set(watch.toJson());
      _brandmodel.add(watch);
      notifyListeners();
    }
    catch(e){
      print(e);
    }
  }
  getBrandModels() async {
    var snapshot = await kDatabase.child('watchmodels').once();
    if (snapshot.value != null) {

      var map=snapshot.value;

      map.forEach((key, value) {

        watch_model_Model temp=watch_model_Model();
        value.forEach((key1,value1){
          temp=watch_model_Model.fromJson(value1);
          temp.watch_brand=key.toString().toUpperCase();
          _brandmodel.add(temp);

        });


      });
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
  void registeredContest(UserModel user){
    try{


      kDatabase.child('contest').child(user.userId).set(user.toJson());
    }catch(e){

      print(e);
      print("Error registering in contest");
    }

}

}
