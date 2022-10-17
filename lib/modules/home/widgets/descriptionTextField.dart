import 'package:flutter/material.dart';
import 'package:flutter_app_note/utils/color_constants.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    Key? key,
    required TextEditingController descriptionController,
    required Size size,
  })  : _descriptionController = descriptionController,
        _size = size,
        super(key: key);

  final TextEditingController _descriptionController;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      selectionControls: MaterialTextSelectionControls(),
      controller: _descriptionController,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Description",
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
              color: AppColors.lightGray,
              fontSize: _size.width * 0.05,
            ),
        contentPadding: EdgeInsets.symmetric(
          vertical: _size.width * 0.02,
          horizontal: _size.width * 0.02,
        ),
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: _size.width * 0.05,
          ),
    );
  }
}
