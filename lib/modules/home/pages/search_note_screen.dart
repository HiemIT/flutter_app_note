import 'package:flutter/material.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_bloc.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_event.dart';
import 'package:flutter_app_note/modules/home/blocs/search/search_state.dart';
import 'package:flutter_app_note/modules/home/components/empty_notes_ui_widget.dart';
import 'package:flutter_app_note/modules/home/pages/note_item_screen.dart';
import 'package:flutter_app_note/modules/home/widgets/buildActionIcon.dart';
import 'package:flutter_app_note/utils/color_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/assets_constants.dart';
import '../models/note.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  late Size _size;
  late final TextEditingController _searchController;
  late List<Note> _noteList;
  late List<Note> _filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<SearchBloc>().add(SearchFetchNotesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    _size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Search Note'),
      centerTitle: true,
      leading: buildActionIcon(
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 15.0,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        top: _size.height * 0.02,
        left: _size.height * 0.035,
        right: _size.height * 0.035,
      ),
      child: Column(
        children: [
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return _buildSearchBar();
            },
          ),
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchInitialState || state is SearchLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.white,
                ));
              } else if (state is SearchLoadedState) {
                _noteList = state.notes;
                _filteredList = _noteList;
                return _buildEmptyOrList();
              } else if (state is SearchGetNotesWithQueryState) {
                _filteredList = state.filteredNotes;
                return _buildEmptyOrList();
              } else if (state is SearchErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(child: Text('No data'));
              }
            },
          )),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      cursorColor: AppColors.orange,
      onChanged: (value) {
        BlocProvider.of<SearchBloc>(context)
            .add(SearchGetNotesWithQueryEvent(query: value, notes: _noteList));
      },
      autofocus: true,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.04,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkGray,
        hintText: "Search Note Here ...",
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.04,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        suffixIcon: _searchController.text.isEmpty
            ? const Icon(
                Icons.search,
                color: AppColors.white,
              )
            : IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<SearchBloc>().add(SearchFetchNotesEvent());
                },
                icon: const Icon(
                  Icons.cancel,
                  color: AppColors.white,
                ),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
      ),
    );
  }

  Widget _buildNotesListView() {
    return Padding(
      padding: EdgeInsets.only(top: _size.width * 0.07),
      child: ListView.builder(
        itemCount: _filteredList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: _size.height * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: _size.width * 0.04,
              vertical: _size.height * 0.02,
            ),
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteItem(
                              note: _filteredList[index],
                            )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _filteredList[index].title ?? '',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.white,
                          fontSize: _size.width * 0.04,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    _filteredList[index].description ?? '',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.lightGray,
                          fontSize: _size.width * 0.04,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyOrList() {
    return _filteredList.isNotEmpty
        ? _buildNotesListView()
        : buildEmptyNotesUi(
            _size,
            path: AssetsConsts.svgNotFound,
          );
  }
}
