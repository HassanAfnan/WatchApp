
import 'package:flutter/material.dart';

class Cart {
  String id;
  String title;
  int quantity;
  double price;

  Cart(this.id,this.title,this.quantity,this.price);
}
class Slider {
  String slider_url;
  String link_url;
  String key;

  Slider(this.slider_url,this.link_url);
  Slider.fromJson(Map<dynamic, dynamic> map) {
    slider_url=map["slider_url"].toString();
    link_url=map["link_url"]==null?"":map["link_url"].toString();
    key=map["key"]==null?"":map["key"];

  }
  Map<String, dynamic> toJson() => {
    "slider_url":slider_url,
    "link_url":link_url,
    "key":key
  };
}