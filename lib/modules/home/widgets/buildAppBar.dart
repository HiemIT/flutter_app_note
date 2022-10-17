import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/components/awesome_dialog.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/widgets/buildActionIcon.dart';
import 'package:flutter_app_note/utils/assets_constants.dart';

import '../pages/search_note_screen.dart';

AppBar buildAppBar(BuildContext context, List<Note> notes) {
  return AppBar(
    title: const Text("Notes Keeper"),
    actions: [
      buildActionIcon(
        rightMargin: 10.0,
        onPressed: () {
          //  check if list note is empty
          if (notes.isNotEmpty) {
            awesomeDialog(context, DeleteAllNotesEvent(),
                    desc:
                        "This action cannot be undone. All the notes will be deleted permanently.")
                .show();
          } else {
            // call function showSnackBar
            showSnackBar(context, "No notes to delete");
          }
        },
        iconPath: AssetsConsts.icDustbin,
      ),
      buildActionIcon(
        rightMargin: 8.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SearchNoteScreen(),
            ),
          );
        },
        iconPath: AssetsConsts.icSearch,
      ),
    ],
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
