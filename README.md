# flutter_app_note

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


// ví dụ về List<Map<String, dynamic>>
// var list = [
//   {
//     'id': 1,
//     'title': 'Title 1',
//     'description': 'Description 1',
//     'date': '2021-09-10 09:00:00.000',
//   },
//   {
//     'id': 2,
//     'title': 'Title 2',
//     'description': 'Description 2',
//     'date': '2021-09-10 09:00:00.000',
//   },
//   ];
//   // Chuyển đổi List<Map<String, dynamic>> sang List<Note>
//   var listNote = list.map((note) => Note.fromMap(note)).toList();
//   print(listNote);
//   // Kết quả:
//   // [Note(id: 1, title: Title 1, description: Description 1, date: 2021-09-10 09:00:00.000), Note(id: 2, title: Title 2, description: Description 2, date: 2021-09-10 09:00:00.000)]

#GlobalKey

GlobalKey là một đối tượng được sử dụng để truy cập một widget nào đó trong cây widget. 
Nó được sử dụng để truy cập một widget nào đó mà không cần biết được vị trí của nó trong cây widget.
Nó cũng có thể được sử dụng để truy cập một widget nào đó mà không cần truyền dữ liệu qua các widget cha.

//  copyWith là một hàm để tạo ra một đối tượng mới với các thuộc tính giống như đối tượng hiện tại nhưng có thể thay đổi một số thuộc tính.
//  Ví dụ:
//  var note = Note(
//    id: 1,
//    title: "Title",
//    description: "Description",
//    time: DateTime.now(),
//  );
//  var note2 = note.copyWith(title: "Title 2");
//  print(note2.title); // In ra "Title 2"
//  print(note2.description); // In ra "Description"
//  print(note2.time); // In ra "2021-09-10 09:00:00.000"