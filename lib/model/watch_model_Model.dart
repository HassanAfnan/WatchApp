import 'package:flutter_twitter_clone/model/user.dart';

class watch_model_Model {
  String watch_model;
  String watch_model_description;
  String watch_brand;

  watch_model_Model(
      {
    this.watch_model,
        this.watch_model_description
      });
  toJson() {
    return {
    "model_number":watch_model,
      "model_description":watch_model_description,

    };
  }

  watch_model_Model.fromJson(Map<dynamic, dynamic> map) {
    watch_model=map["model_number"];
    watch_model_description=map["model_description"];

  }

}
