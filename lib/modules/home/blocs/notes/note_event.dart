// Khi dùng bloc thì ta sẽ tạo ra các event để xử lý các logic trong app.
// Ví dụ như 1 event để lấy tất cả các note từ database.
// Sau đó ta sẽ tạo ra 1 bloc để xử lý logic của event đó.
// Ta tao state để lưu trữ các giá trị của các event.
// Tạo even trước hay state trước thì cũng được, nhưng mình thích tạo event trước. Vì mình thấy nó dễ hiểu hơn. Hiem Thích điều đó :import '../models/note.dart';

import '../../models/note.dart';

abstract class NotesEvent {
  NotesEvent({this.notes});

  List<Note>? notes;
}

class FetchNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  AddNote({this.note}) : super();

  Note? note;

//  in ra giá trị của note
  @override
  String toString() => 'AddNote { note: $note }';
}

class DeleteNoteEvent extends NotesEvent {
  DeleteNoteEvent(this.id);

  int id;
}

class DeleteAllNotesEvent extends NotesEvent {}

class UpdateNoteEvent extends NotesEvent {
  UpdateNoteEvent(this.note);

  Note note;
}

class showNotesInGridView extends NotesEvent {}

class showNotesInListView extends NotesEvent {}

class CloseDBEvent extends NotesEvent {}
