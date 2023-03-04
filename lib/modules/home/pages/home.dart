import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_event.dart';
import 'package:flutter_app_note/modules/home/blocs/notes/note_state.dart';
import 'package:flutter_app_note/modules/home/components/awesome_dialog.dart';
import 'package:flutter_app_note/modules/home/models/note.dart';
import 'package:flutter_app_note/modules/home/pages/add_note_page.dart';
import 'package:flutter_app_note/modules/home/pages/note_item_screen.dart';
import 'package:flutter_app_note/modules/home/widgets/buildAppBar.dart';
import 'package:flutter_app_note/utils/color_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../utils/assets_constants.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

// enum ViewType { list, grid }

class _HomeAppState extends State<HomeApp> {
  late Size _size;
  late List<Note> _noteList;
  bool _showGrid = true;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _noteList = [];
  }

  @override
  void dispose() {
    closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, _noteList),
      body: _buildBody(),
      floatingActionButton: _buildAddNoteFAB(),
    );
  }

  Widget _buildAddNoteFAB() {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(seconds: 2),
      tween: Tween<Offset>(
        begin: const Offset(0, -800),
        end: const Offset(0, 0),
      ),
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddNotePage(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: AppColors.codGray,
          size: _size.width * 0.08,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: _size.height * 0.015,
              right: _size.height * 0.015,
              bottom: _size.height * 0.015,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: _size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.darkGray,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        "Notes",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: AppColors.lightGray,
                            ),
                      ),
                    ),
                  ),
                ),
                buildListingIcon(() {
                  // _viewTypeController.add(ViewType.grid);
                  //  get state from bloc
                  context.read<NoteBloc>().add(showNotesInGridView());
                }, AssetsConsts.icGrid),
                buildListingIcon(() {
                  // _viewTypeController.add(ViewType.list);
                  context.read<NoteBloc>().add(showNotesInListView());
                }, AssetsConsts.icList),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NoteBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoadingState || state is NotesInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  );
                } else if (state is NotesLoadedState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is AllNotesDeletedState) {
                  _noteList = [];
                  return _buildListOrEmpty();
                } else if (state is ShowNotesInViewState) {
                  _showGrid = state.inGrid;
                  return _buildListOrEmpty();
                } else if (state is DeleteNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is CreateNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is UpdateNoteState) {
                  _noteList = state.notes;
                  return _buildListOrEmpty();
                } else if (state is NotesErrorState) {
                  return Center(          
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesGridView() {
    return AnimationLimiter(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _size.height * 0.01,
        crossAxisSpacing: _size.height * 0.01,
      ),
      itemCount: _noteList.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: 2,
          duration: const Duration(milliseconds: 500),
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: Card(
                color: AppColors.list[random.nextInt(AppColors.list.length)],
                child: InkWell(
                  onLongPress: () async {
                    await awesomeDialog(
                            context, DeleteNoteEvent(_noteList[index].id!))
                        .show();
                  },
                  onTap: onTapNoteItem(index),
                  enableFeedback: true,
                  splashColor: AppColors.white,
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      return Padding(
                        padding:
                            EdgeInsets.all(innerConstraints.maxHeight * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _noteList[index].title ?? "",
                                  maxLines: 4,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontSize:
                                            innerConstraints.maxHeight * 0.115,
                                      ),
                                ),
                              ),
                            ),
                            Text(
                              _noteList[index].time.toString(),
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontSize: innerConstraints.maxHeight * 0.08,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Widget _buildNotesListView() {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: _noteList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ObjectKey(_noteList[index]),
            direction: DismissDirection.startToEnd,
            confirmDismiss: deleteNoteConfirmDismiss(index),
            background: Container(
              color: Colors.red,
              margin: EdgeInsets.all(_size.height * 0.0080),
              padding: EdgeInsets.all(_size.height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    height: _size.width * 0.008,
                  ),
                  Text("Delete"),
                ],
              ),
            ),
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: _size.width * 0.01),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: AppColors
                            .list[random.nextInt(AppColors.list.length)],
                        child: InkWell(
                          onTap: onTapNoteItem(index),
                          splashColor: AppColors.white,
                          child: Padding(
                            padding: EdgeInsets.all(_size.width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _noteList[index].title!,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontSize: _size.width * 0.050,
                                      ),
                                ),
                                SizedBox(
                                  height: _size.width * 0.015,
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(_noteList[index].time!),
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: _size.width * 0.035,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListOrEmpty() {
    if (_noteList.isEmpty) {
      return buildEmptyNotesUi(_size, path: AssetsConsts.svgEmptyNotes);
    } else {
      return _showGrid ? _buildNotesGridView() : _buildNotesListView();
    }
  }

  Widget buildListingIcon(VoidCallback onPressed, iconPath) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
        width: 16.0,
        height: 16.0,
      ),
      padding: EdgeInsets.zero,
      splashRadius: 30.0,
    );
  }

  Widget buildEmptyNotesUi(Size size, {required String path}) {
    return Center(
      child: Opacity(
        opacity: 0.5,
        child: SvgPicture.asset(
          path,
          width: size.width * 0.7,
          height: size.width * 0.7,
        ),
      ),
    );
  }

  void closeDB() => context.read<NoteBloc>().add(CloseDBEvent());

  VoidCallback onTapNoteItem(int index) {
    return () async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<NoteBloc>(),
            child: NoteItem(
              note: _noteList[index],
            ),
          ),
        ),
      );
    };
  }

  ConfirmDismissCallback deleteNoteConfirmDismiss(int index) {
    return (DismissDirection direction) async =>
        await awesomeDialog(context, DeleteNoteEvent(_noteList[index].id!))
            .show();
  }
}
