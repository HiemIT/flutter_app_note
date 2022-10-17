import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/components/awesome_dialog.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/pages/add_note_page.dart';
import 'package:flutter_app_note/modules/home/widgets/buildActionIcon.dart';
import 'package:flutter_app_note/utils/color_constants.dart';

import '../../../utils/assets_constants.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late Size _size;
  late Note _note;

  @override
  void initState() {
    super.initState();
    _note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; // get screen size
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: _size.height * 0.02,
          left: _size.height * 0.035,
          right: _size.height * 0.035,
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            _note.title ?? "",
            maxLines: null,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColors.white,
                  fontSize: _size.width * 0.08,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        SizedBox(height: _size.height * 0.04),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                _note.description ?? '',
                maxLines: null,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: _size.width * 0.05,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
      actions: [
        buildActionIcon(
          icon: Icons.edit,
          onPressed: () async {
            // await awesomeDialog(context).show();
            await awesomeDialog(context, DeleteNoteEvent(_note.id!)).show();
            Navigator.pop(context);
          },
          rightMargin: 15.0,
          iconPath: AssetsConsts.icDustbin,
        ),
        buildActionIcon(
          onPressed: () async {
            _note = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddNotePage(
                  note: _note,
                ),
              ),
            );
          },
          rightMargin: 15.0,
          icon: Icons.edit_outlined,
        ),
      ],
    );
  }
}
