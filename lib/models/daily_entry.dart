import './emotion.dart';

class DailyEntryModel {
  int? id;
  DateTime date;
  EmotionModel emotion;
  String journalEntry;
  DateTime createdAt;
  DateTime updatedAt;

  DailyEntryModel({
    this.id,
    required this.date,
    required this.emotion,
    required this.journalEntry,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'journal_entry': journalEntry,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory DailyEntryModel.fromJson(Map<String, dynamic> json) {
    return DailyEntryModel(
      id: json['id'],
      date: json['date'],
      emotion: json['emotion'],
      journalEntry: json['journalEntry'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
