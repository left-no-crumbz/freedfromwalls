import 'package:freedfromwalls/models/user.dart'; // Assuming this import is needed

class FeelModel {
  int? id;
  String? title;
  String? description;
  int? userId;

  FeelModel({this.id, this.title, this.description, this.userId});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description, 'userId': userId};
  }

  factory FeelModel.fromJson(Map<String, dynamic> json) {
    return FeelModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
    );
  }
}