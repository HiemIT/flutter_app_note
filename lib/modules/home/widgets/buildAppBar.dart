import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/components/awesome_dialog.dart';
import 'package:flutter_app_note/modules/home/widgets/buildActionIcon.dart';
import 'package:flutter_app_note/utils/assets_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/search_note_screen.dart';

AppBar buildAppBar(BuildContext context) {
  final _noteBloc = BlocProvider.of<NoteBloc>(context);
  return AppBar(
    title: const Text("Notes Keeper"),
    actions: [
      // if list note is empty, disable buildActionIcon icDustbin and icSearch
      buildActionIcon(
        rightMargin: 10.0,
        onPressed: () async {
          awesomeDialog(context, DeleteAllNotesEvent(),
                  desc:
                      "This action cannot be undone. All the notes will be deleted permanently.")
              .show();
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
