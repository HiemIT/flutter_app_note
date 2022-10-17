import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/widgets/titleTextField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/descriptionTextField.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key, this.note}) : super(key: key);
  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late Size _size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late Note _note;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.text = widget.note?.title ?? '';
    _descriptionController.text = widget.note?.description ?? '';

    //  GlobalKey là một đối tượng khóa duy nhất được sử dụng để định danh một widget.
    //  Nó được sử dụng để truy cập một widget nào đó trong cây widget.
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Add Note"),
      actions: [
        IconButton(
          onPressed: onSave,
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    _size = MediaQuery.of(context).size;
    print("Rebuild");
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TitleTextField(
              size: _size,
              controller: _titleController,
            ),
            Expanded(
              child: DescriptionTextField(
                  descriptionController: _descriptionController, size: _size),
            ),
          ],
        ),
      ),
    );
  }

  void onSave() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (widget.note != null) {
        updateNote();
        Navigator.pop(context, _note);
      } else {
        insertNote();
        Navigator.pop(context);
      }
    }
  }

  void updateNote() {
    _note = widget.note!.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<NoteBloc>().add(UpdateNoteEvent(_note));
  }

  void insertNote() {
    context.read<NoteBloc>().add(
          AddNote(
            note: Note(
              title: _titleController.text,
              description: _descriptionController.text,
              time: DateTime.now(),
            ),
          ),
        );
  }
}
