import 'package:flutter_app_note/modules/home/blocs/search/search_event.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_state.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/repos/note_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NoteRepository _notesRepository = NoteRepository();

  SearchBloc() : super(SearchInitialState()) {
    on<SearchFetchNotesEvent>(
      (event, emit) async {
        emit(SearchLoadingState());
        try {
          //  TODO: Lấy dữ liệu từ database và trả về trạng thái SearchLoadedState
          List<Note> notes = await _notesRepository.getAllNotes();
          emit(SearchLoadedState(notes));
        } catch (e) {
          emit(SearchErrorState(e.toString()));
        }
      },
    );
    on<SearchGetNotesWithQueryEvent>((event, emit) async {
      try {
        // Lấy danh sách notes mà ta đã tìm kiếm được từ database trước đó
        List<Note> notes = event.notes;
        // Lọc danh sách notes theo query của người dùng
        List<Note> filteredNotes = [];

        filteredNotes = notes
            .where(
              (note) =>
                  // Lọc theo title
                  note.title!.toLowerCase().contains(event.query.toLowerCase()),
              // Lọc theo description
            )
            .toList();
        //  check xem query có rỗng hay không
        if (event.query.isEmpty) {
          // Nếu rỗng thì trả về trạng thái SearchLoadedState với danh sách notes là danh sách notes mà ta đã lấy từ database
          emit.call(SearchGetNotesWithQueryState(notes));
        } else {
          // Nếu không rỗng thì trả về trạng thái SearchLoadedState với danh sách notes là danh sách notes mà ta đã lọc được
          emit.call(SearchGetNotesWithQueryState((filteredNotes)));
        }
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }
}
