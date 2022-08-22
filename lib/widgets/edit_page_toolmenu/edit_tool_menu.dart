import 'package:flutter/material.dart';

class EditToolMenu extends StatelessWidget {
  final List<Widget>? children;
  const EditToolMenu({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: children != null ? null : 56,
      width: size.width,
      // margin: EdgeInsets.ontl(vertical: 20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, 
          // borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children ?? [],
      ),
    );
  }
}
