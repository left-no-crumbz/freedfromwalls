import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/last_edited_info.dart';

import 'customThemes.dart';

class JournalEntryContainer extends StatelessWidget {
  final String journalEntry;
  final DateTime? creationDate;
  final DateTime? editedDate;

  const JournalEntryContainer({
    Key? key,
    required this.journalEntry,
    this.creationDate,
    this.editedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: const Color(0xff000000)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Journal Entry",
            style: TextStyle(
              fontSize: AppThemes.getResponsiveFontSize(context, 16),
              fontWeight: FontWeight.bold,
              fontFamily: "Jua",
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                journalEntry.isEmpty ? "No entry yet" : journalEntry,
                style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 14),
                    fontFamily: "Jua",
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          if (creationDate != null && editedDate != null)
            LastEditedInfo(creationDate: creationDate!, editedDate: editedDate!)
        ],
      ),
    );
  }
}
