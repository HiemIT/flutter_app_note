import 'package:flutter_app_note/modules/home/models/note.dart';

abstract class SearchState {}

/*
* TODO 1: Khi người dùng trả cho bloc một event FetchNotes thì ta sẽ trả về trạng thái là NotesInitialState để hiển thị màn hình ban đầu của ứng dụng là màn hình chứa các ghi chú của người dùng đang sử dụng ứng dụng đó
* TODO 2: Khi người dùng trả cho bloc một event SearchGetNotesWithQueryEvent thì ta sẽ trả về trạng thái là SearchLoadingState để hiển thị màn hình loading cho người dùng và khi đã tìm kiếm xong thì ta sẽ trả về trạng thái là SearchLoadedState để hiển thị màn hình kết quả tìm kiếm của người dùng
* TODO 3: Khi người dùng trả cho bloc một event SearchGetNotesWithQueryEvent thì ta sẽ trả về trạng thái là SearchErrorState để hiển thị màn hình lỗi cho người dùng nếu có lỗi xảy ra
* DONE!! :))
*/

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  List<Note> notes;

  SearchLoadedState(this.notes);
}

class SearchGetNotesWithQueryState extends SearchState {
  List<Note> filteredNotes;

  SearchGetNotesWithQueryState(this.filteredNotes);
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}
