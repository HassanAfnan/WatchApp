class BlogModel{
  String title;
  String description;
  String image;
  String date;
  String key;
  BlogModel(this.title,this.description,this.image,this.date); toJson() {
    return {
      "key":key,
      "title":title,
      "description":description,
      "image":image,
      "date":date,


    };
  }

  BlogModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    description = map['description'];
    title=map["title"];
    image=map["image"];
    date=map["date"];

  }
}



