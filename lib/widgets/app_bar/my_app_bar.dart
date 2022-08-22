import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? buttonText;
  final Function()? onPressed;
  final double? fontSize;
  final Color? textColor;
  final Widget? buttonChild;
  const MyAppBar({Key? key, this.title, this.onPressed, this.fontSize, this.buttonText, this.textColor, this.buttonChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "App",
        style: TextStyle(fontFamily: 'McLaren', fontSize: fontSize ?? 18,color: textColor ??Colors.black),
      ),
      elevation: 0,
      actions: onPressed == null
          ? null
          : [
              TextButton(
                onPressed: onPressed,
                child: buttonChild ?? Text( buttonText??"Save",
                    style: TextStyle(fontFamily: 'McLaren', fontSize: 18, color: textColor ?? Colors.red)),
              )
            ],
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          color: textColor ??Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 56);
}
