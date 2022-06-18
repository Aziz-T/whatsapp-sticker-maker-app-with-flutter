import 'package:flutter/material.dart';

class AddTextWidget extends StatelessWidget {
  const AddTextWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 10,
        decoration: InputDecoration(
          focusedErrorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none
        ),
      ),
    );
  }
}
