import 'package:flutter_twitter_clone/model/user.dart';

class watchModel {
  String key;
  String description;
  String title;
  String userId;
  String imagePath;
  String condition;
  String type;
  String price;
  UserModel user;
  String createdAt;
  watchModel(
      {this.key,
      this.description,
      this.userId,
      this.imagePath,
      this.user,
        this.title,
        this.type,
        this.price,
        this.condition,
        this.createdAt
      });
  toJson() {
    return {
      "userId": userId,
      "description": description,
      "imagePath": imagePath,
      "user": user == null ? null : user.toJson(),
      "title":title,
      "type":type,
      "price":price,
      "condition":condition,
      "createdAt":createdAt
    };
  }

  watchModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    description = map['description'];
    userId = map['userId'];
   condition=map["condition"];
   price=map["price"];
   type=map["type"];
    imagePath = map['imagePath'];
    createdAt = map['createdAt'];
    imagePath = map['imagePath'];
    title=map["title"];
    user = UserModel.fromJson(map['user']);

  }

}
