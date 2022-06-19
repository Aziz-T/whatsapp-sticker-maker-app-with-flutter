import 'package:flutter/material.dart';

class AddTextWidget extends StatelessWidget {
  const AddTextWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: buildTextField(),
      child: Container(
        height: 40,
        width: 90,
        color: Colors.red,
        child: buildTextField(),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
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
      );
  }
}
