class BlackListModel {
  int? id;
  String? body;

  BlackListModel({this.id, this.body});

  Map<String, dynamic> toJson() {
    return {'id': id, 'body': body};
  }

  factory BlackListModel.fromJson(Map<String, dynamic> json) {
    return BlackListModel(
      id: json["id"],
      body: json["body"],
    );
  }
}
