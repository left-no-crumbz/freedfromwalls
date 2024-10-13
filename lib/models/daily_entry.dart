import 'package:freedfromwalls/models/user.dart';

import './emotion.dart';
import './additional_note.dart';

class DailyEntryModel {
  int? id;
  UserModel user;
  EmotionModel? emotion;
  String journalEntry;
  List<AdditionalNoteModel>
      additionalNotes; // Representing the one-to-many relationship
  DateTime? createdAt;
  DateTime? updatedAt;

  DailyEntryModel({
    this.id,
    required this.user,
    this.emotion,
    required this.journalEntry,
    required this.additionalNotes,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'emotion': emotion?.toJson(),
      'journal_entry': journalEntry,
      'additional_notes': additionalNotes.map((note) => note.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory DailyEntryModel.fromJson(Map<String, dynamic> json) {
    return DailyEntryModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      emotion: EmotionModel.fromJson(json['emotion']),
      journalEntry: json['journal_entry'],
      additionalNotes: (json['additional_notes'] as List)
          .map((noteJson) => AdditionalNoteModel.fromJson(noteJson))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
