/*{
  "userId": 1,
  "id": 1,
  "title": "quidem molestiae enim"
} */
class Album {
  int ?userId;
  int ?id;
  String ?title;

  Album({required this.userId, required this.id, required this.title});

  int? getId(){
    return id;
  }
  //取得標題
  String getTitle()
  {
    return title ?? "";
  }
  // JSON解析
  factory Album.fromJson(Map<String, dynamic> jsonMap) {
    return Album(
      userId: jsonMap['userId'],
      id: jsonMap['id'],
      title: jsonMap['title'],
    );
  }
}
