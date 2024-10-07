class EmotionModel {
  int? id;
  String title;
  String name;
  String color;

  EmotionModel({
    this.id,
    required this.name,
    required this.title,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'color': color,
    };
  }

  factory EmotionModel.fromJson(Map<String, dynamic> json) {
    return EmotionModel(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      color: json['color'],
    );
  }
}
