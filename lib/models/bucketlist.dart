import 'package:freedfromwalls/models/user.dart';

class BucketListModel {
  int? id;
  String? body;
  int? userId;
  BucketListModel({this.id, this.body, this.userId});

  Map<String, dynamic> toJson() {
    return {'id': id, 'body': body, "userId": userId};
  }

  factory BucketListModel.fromJson(Map<String, dynamic> json) {
    return BucketListModel(
      id: json["id"],
      body: json["body"],
      userId: json["userId"],
    );
  }
}
