import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AwesomeDialog awesomeDialog(BuildContext context, NotesEvent event,
    {String? title, String? desc}) {
  return AwesomeDialog(
    context: context,
    keyboardAware: true,
    dismissOnBackKeyPress: false,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    btnCancelText: "No",
    btnOkText: "Yes",
    title: title ?? 'Do you really want to delete the note?',
    // padding: const EdgeInsets.all(5.0),
    desc: desc ??
        'This action cannot be undone. All the notes will be deleted permanently.',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      context.read<NoteBloc>().add(event);
    },
  );
}
