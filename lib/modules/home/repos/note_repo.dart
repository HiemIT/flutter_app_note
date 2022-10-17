import 'package:flutter_app_note/db/note_table.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';

class NoteRepository {
  // Tao 1 instance cua NoteRepo
  // instance nghĩa là 1 cái gì đó duy nhất trong 1 khoảng thời gian nào đó.
  // mục đích để tránh việc tạo nhiều instance của 1 class.
  // Ví dụ như 1 class NoteRepo thì chỉ cần 1 instance thôi. Không cần tạo nhiều instance.
  // Vì nếu tạo nhiều instance thì sẽ tốn bộ nhớ và tốn thời gian.
  // Vì vậy để tránh việc tạo nhiều instance thì ta sẽ tạo 1 instance duy nhất và dùng chung cho tất cả các nơi cần dùng.
  final NoteTable _noteTable = NoteTable();

  Future<List<Note>> getAllNotes() async => await _noteTable.readAllNotes();
  Future<void> closeDB() async => await _noteTable.closeDatabase();
  Future<bool> deleteAllNotes() async => await _noteTable.deleteNotes();
  Future<Note> getNoteById(int id) async => await _noteTable.readNote(id);
  Future<Note> createNote(Note note) async => await _noteTable.insertNote(note);
  Future<bool> deleteNoteById(int id) async => await _noteTable.deleteNote(id);
  Future<bool> updateNoteById(Note note) async =>
      await _noteTable.updateNote(note);
}
