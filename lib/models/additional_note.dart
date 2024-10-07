class AdditionalNoteModel {
  int? id;
  String note;

  AdditionalNoteModel({
    this.id,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
    };
  }

  factory AdditionalNoteModel.fromJson(Map<String, dynamic> json) {
    return AdditionalNoteModel(
      id: json['id'],
      note: json['note'],
    );
  }
}
