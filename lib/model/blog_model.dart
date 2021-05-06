class BlogModel{
  String title;
  String description;
  String image;
  String key;
  BlogModel(this.title,this.description,this.image); toJson() {
    return {
      "key":key,
      "title":title,
      "description":description,
      "image":image,


    };
  }

  BlogModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    description = map['description'];
   title=map["title"];
   image=map["image"];

  }
}

List<BlogModel> blog = [
  BlogModel("A good blog","No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging","https://www.start-business-online.com/images/thumbs/420_270/article_manager_uploads/blog.jpg"),
  BlogModel("A good blog","No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging","https://www.start-business-online.com/images/thumbs/420_270/article_manager_uploads/blog.jpg"),
  BlogModel("A good blog","No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging","https://www.start-business-online.com/images/thumbs/420_270/article_manager_uploads/blog.jpg"),
  BlogModel("A good blog","No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging","https://www.start-business-online.com/images/thumbs/420_270/article_manager_uploads/blog.jpg"),
  BlogModel("A good blog","No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging No internet available, cannot connect to FIRMessaging","https://www.start-business-online.com/images/thumbs/420_270/article_manager_uploads/blog.jpg"),
];

