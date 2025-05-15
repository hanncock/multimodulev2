import 'package:flutter/material.dart';

class Menus{
  final Icon? icona;
  final String? imagePath;
  final String title;
  final Widget widget;

  Menus({
    required this.widget,
    required this.title,
    this.icona,
    this.imagePath
  });

}
