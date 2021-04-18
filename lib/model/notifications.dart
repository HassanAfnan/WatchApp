class Notifications {
  String title;
  String createAt;
  String key;
  String message;

  Notifications({
  this.title,
    this.message,
    this.createAt
  });

  Notifications.fromJson(Map<dynamic, dynamic> map) {
   key=map["key"];
   title=map["title"];
   createAt=map["createdAt"]==null?"2020-04-14":map["createdAt"];
   message=map["message"];

  }

  Map<String, dynamic> toJson() => {
    "key":key,
    "title":title,
    "createdAt":createAt,
    "message":message
      };
}
