import 'package:flutter/material.dart';
import 'package:habbi_tracker/constants/colors.dart';

const TextStyle descriptionStyle =
    TextStyle(fontSize: 12, color: textLight, fontWeight: FontWeight.w200);

const textInputDecoration = InputDecoration(
  hintText: "Enter email",
  hintStyle: TextStyle(
    color: textLight,
  ),
  fillColor: bgBlack,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
);
