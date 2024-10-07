class AdditionalNoteModel {
  int? id;
  String note;
  int dailyEntryId;

  AdditionalNoteModel(
      {this.id, required this.note, required this.dailyEntryId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'daily_entry': dailyEntryId,
    };
  }

  factory AdditionalNoteModel.fromJson(Map<String, dynamic> json) {
    return AdditionalNoteModel(
      id: json['id'],
      note: json['note'],
      dailyEntryId: json['daily_entry'],
    );
  }
}
