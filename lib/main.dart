import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_note/app.dart';
import 'package:flutter_app_note/common/bloc/chatty_bloc_observer.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> arguments) {
  Bloc.observer = ChattyBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<NoteBloc>(
        create: (context) => NoteBloc()..add(FetchNotes()),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc()..add(SearchFetchNotesEvent()),
      ),
    ],
    child: const MyApp(),
  ));
}
