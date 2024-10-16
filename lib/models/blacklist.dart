class BlackListModel {
  int? id;
  String? body;
  int? userId;

  BlackListModel({this.id, this.body, this.userId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'userId': userId,
    };
  }

  factory BlackListModel.fromJson(Map<String, dynamic> json) {
    return BlackListModel(
      id: json["id"],
      body: json["body"],
      userId: json["userId"],
    );
  }
}
