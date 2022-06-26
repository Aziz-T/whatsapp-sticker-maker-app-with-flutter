import 'package:flutter/material.dart';

class SavedImageItem extends StatelessWidget {
  const SavedImageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ]
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Image.asset("assets/img.jpg"),
    );
  }
}
