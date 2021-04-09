import 'package:flutter_twitter_clone/model/user.dart';

class watchModel {
  String key;
  String description;
  String title;
  String userId;
  String imagePath;
  String condition;
  String type;
  String model_number;
  String price;
  String sales_price;

  String trades_price;
  UserModel user;
  String createdAt;
  String selltype;
  bool fully_boxed;
  int watch_condition;
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
        this.createdAt,
        this.selltype,
        this.fully_boxed,
        this.watch_condition,
        this.sales_price,
        this.trades_price,
        this.model_number
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
      "createdAt":createdAt,
      "selltype":selltype==null?"":selltype,
      "fully_boxed":fully_boxed==null?false:fully_boxed,
      "watch_condition":watch_condition==null?0:watch_condition,
      "sales_price":sales_price==null?'0':sales_price,
      "trade_price":trades_price==null?'0':trades_price,
      "model_number":model_number==null?'':model_number
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
    selltype=map["selltype"]==null?"":map["selltype"];
    fully_boxed=map["fully_boxed"]==null?false:map["fully_boxed"];
    watch_condition=map["watch_condition"]==null?0:map["watch_condition"];
    sales_price=map["sales_price"]==null?'0':map["sales_price"];
    model_number=map["model_number"]==null?'':map['model_number'];
    trades_price=map["trade_price"]==null?'0':map['trade_price'];

  }

}
