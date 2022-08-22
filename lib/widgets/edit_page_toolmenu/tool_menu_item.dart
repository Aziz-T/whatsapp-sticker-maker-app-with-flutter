
import 'package:flutter/material.dart';

import '../../values/styles/TextStyles.dart';

class ToolMenuItem extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? iconData;
  final String? title;
  const ToolMenuItem({Key? key, this.onTap, this.iconData, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(color: Colors.white, boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 3,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ]),
        child: Column(
          children: [
            Icon(
              iconData ?? Icons.add_a_photo,
              color: Colors.lightBlue,
            ),
            FittedBox(child: Text("$title", style:  TextStyles.mcLarenStyle.copyWith(fontSize: 12,),))
          ],
        ),
      ),
    );
  }
}
