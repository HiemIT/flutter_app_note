import 'package:flutter/material.dart';
import 'package:flutter_app_note/utils/color_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildActionIcon({
  required VoidCallback onPressed,
  required double rightMargin,
  double leftMargin = 0.0,
  String? iconPath,
  IconData? icon,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      right: rightMargin,
      left: leftMargin,
    ),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: AppColors.darkGray,
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: Material(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: iconPath != null
              ? SvgPicture.asset(
                  iconPath,
                  width: 20.0,
                  height: 20.0,
                )
              : Icon(icon, size: 20.0),
        ),
      ),
    ),
  );
}
