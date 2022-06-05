import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const MyAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text( title ??"App"),
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.bold),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 80);
}
