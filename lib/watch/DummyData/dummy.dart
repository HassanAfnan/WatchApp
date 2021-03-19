import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/model/Watches.dart';
import 'package:flutter_twitter_clone/model/cart.dart';
import 'package:flutter_twitter_clone/model/news_model.dart';

List<Watches> watches = [
  Watches("1","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 20.8, 5, "https://images.pexels.com/photos/266666/pexels-photo-266666.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("2","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 80.8, 4, "https://images.pexels.com/photos/2113994/pexels-photo-2113994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("3","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 90.8, 3, "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("4","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 50.8, 4, "https://images.pexels.com/photos/592815/pexels-photo-592815.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("5","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 230.8, 2, "https://images.pexels.com/photos/158741/gshock-watch-sports-watch-stopwatch-158741.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("6","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 29.8, 3 ,"https://images.pexels.com/photos/364822/rolex-watch-time-luxury-364822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("7","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 78.8, 2, "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("8","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 29.8, 4, "https://images.pexels.com/photos/364822/rolex-watch-time-luxury-364822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
];

List<Cart> cartItems = [
  Cart("1","Rolax",2,40.0),
  Cart("8","buk",2,40.0),
];

List<Watches> myWatches = [
  Watches("1","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 20.8, 5, "https://images.pexels.com/photos/266666/pexels-photo-266666.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("2","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 80.8, 4, "https://images.pexels.com/photos/2113994/pexels-photo-2113994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("3","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 90.8, 3, "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("4","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 50.8, 4, "https://images.pexels.com/photos/592815/pexels-photo-592815.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
];

List<Watches> saleWatches = [
  Watches("4","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 50.8, 4, "https://images.pexels.com/photos/592815/pexels-photo-592815.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("5","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 230.8, 2, "https://images.pexels.com/photos/158741/gshock-watch-sports-watch-stopwatch-158741.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("6","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 29.8, 3 ,"https://images.pexels.com/photos/364822/rolex-watch-time-luxury-364822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("7","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 78.8, 2, "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("8","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 29.8, 4, "https://images.pexels.com/photos/364822/rolex-watch-time-luxury-364822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
];

List<NewsModel> news = [
  NewsModel("1","GitHub Takes Aim","GitHub Advanced Security will help automatically spot potential security problems in the world's biggest open source platform.","https://media.wired.com/photos/5eb1edb9568b219656eb599b/master/w_2560%2Cc_limit/github-open-source-software-vulnerabilities.jpg"),
  NewsModel("1","GitHub Takes Aim","GitHub Advanced Security will help automatically spot potential security problems in the world's biggest open source platform.","https://media.wired.com/photos/5eb1edb9568b219656eb599b/master/w_2560%2Cc_limit/github-open-source-software-vulnerabilities.jpg"),
  NewsModel("1","GitHub Takes Aim","GitHub Advanced Security will help automatically spot potential security problems in the world's biggest open source platform.","https://media.wired.com/photos/5eb1edb9568b219656eb599b/master/w_2560%2Cc_limit/github-open-source-software-vulnerabilities.jpg"),
  NewsModel("1","GitHub Takes Aim","GitHub Advanced Security will help automatically spot potential security problems in the world's biggest open source platform.","https://media.wired.com/photos/5eb1edb9568b219656eb599b/master/w_2560%2Cc_limit/github-open-source-software-vulnerabilities.jpg")
];

List<Watches> wishList = [
  Watches("1","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 20.8, 5, "https://images.pexels.com/photos/266666/pexels-photo-266666.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("2","Rolex","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 80.8, 4, "https://images.pexels.com/photos/2113994/pexels-photo-2113994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("3","Buk","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 90.8, 3, "https://images.pexels.com/photos/277390/pexels-photo-277390.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
  Watches("4","Mam","A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person's activities. ... A pocket watch is designed for a person to carry in a pocket, often attached to a chain. The study of timekeeping is known as horology", 50.8, 4, "https://images.pexels.com/photos/592815/pexels-photo-592815.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
];