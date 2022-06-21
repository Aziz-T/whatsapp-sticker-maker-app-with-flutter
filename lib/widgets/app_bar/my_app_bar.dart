import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onPressed;
  const MyAppBar({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      title: Text(
        title ?? "App",
        style: TextStyle(fontFamily: 'McLaren'),
      ),
      elevation: 0,
      actions: onPressed == null ? null: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.done,
              color: Colors.black,
            ))
      ],
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 80);
}
