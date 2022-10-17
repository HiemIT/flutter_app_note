import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/repos/note_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'note_state.dart';

class NoteBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository _notesRepository = NoteRepository();

  NoteBloc() : super(NotesInitialState()) {
    on<FetchNotes>(
      (event, emit) async {
        emit.call(NotesLoadingState());
        try {
          List<Note> notes = await _notesRepository.getAllNotes();
          emit.call(NotesLoadedState(notes));
        } catch (e) {
          emit.call(NotesErrorState(e.toString()));
        }
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
    on<AddNote>(
      (event, emit) async {
        await _notesRepository.createNote(event.note!);
        List<Note> notes = await _notesRepository.getAllNotes();
        emit.call(CreateNoteState(notes));
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
    on<DeleteNoteEvent>(
      (event, emit) async {
        await _notesRepository.deleteNoteById(event.id);
        List<Note> notes = await _notesRepository.getAllNotes();
        emit.call(DeleteNoteState(notes));
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
    on<DeleteAllNotesEvent>(
      (event, emit) async {
        await _notesRepository.deleteAllNotes();
        emit.call(AllNotesDeletedState());
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
    on<UpdateNoteEvent>(
      (event, emit) async {
        await _notesRepository.updateNoteById(event.note);
        List<Note> notes = await _notesRepository.getAllNotes();
        emit.call(UpdateNoteState(notes));
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
    on<showNotesInGridView>(
      (event, emit) async {
        emit.call(ShowNotesInViewState(true));
      },
    );
    on<showNotesInListView>(
      (event, emit) async {
        emit.call(ShowNotesInViewState(false));
      },
    );
    on<CloseDBEvent>(
      (event, emit) async {
        await _notesRepository.closeDB();
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
