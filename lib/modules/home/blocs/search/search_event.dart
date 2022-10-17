import 'package:flutter_app_note/modules/home/models/note.dart';

abstract class SearchEvent {}

/*
* TODO 1: Khi người dùng không nhập thì ta gọi event FetchNotes
* TODO 2: Khi người dùng nhập thì ta gọi event theo tìm kiếm của người dùng
* */

class SearchFetchNotesEvent extends SearchEvent {}

class SearchGetNotesWithQueryEvent extends SearchEvent {
  // Cái query này là cái người dùng nhập vào ô search của mình để tìm kiếm ghi chú
  final String query;
  // Cái này là để lưu lại các ghi chú đã tìm kiếm được để khi người dùng nhập thêm thì ta sẽ tìm kiếm trong cái này luôn thay vì phải tìm kiếm lại từ đầu trong database nữa làm tốn thời gian và tài nguyên của ứng dụng :))
  List<Note> notes;
  // chúng ta sẽ nhận được cái query và cái notes từ bloc để xử lý
  SearchGetNotesWithQueryEvent({required this.query, required this.notes});
}
