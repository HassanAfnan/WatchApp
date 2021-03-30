class NewsModel{
  String id;
  String title;
  String description;
  String image;
  String createdAt;
  NewsModel(this.id,this.title,this.description,this.image,this.createdAt);

  NewsModel.fromJson(Map<dynamic, dynamic> map) {
   id=map["id"].toString();
   title=map["title"].toString();
   description=map["description"].toString();
   image=map["image"].toString();
   createdAt=map["createdAt"].toString();
  }

  toJson() {
    return {
      "id":id,
      "title":title,
      "description":description,
      "image":image,
      "createdAt":createdAt
    };
  }
}
