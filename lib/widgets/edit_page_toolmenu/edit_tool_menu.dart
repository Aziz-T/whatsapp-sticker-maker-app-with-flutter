import 'package:flutter/material.dart';

class EditToolMenu extends StatelessWidget {
  final List<Widget>? children;
  const EditToolMenu({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: children != null ? null : 56,
      width: children != null ? null : size.width,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children??[],
        ),
      ),
    );
  }


}
