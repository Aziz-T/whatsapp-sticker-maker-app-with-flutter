import 'package:flutter/material.dart';
import 'package:wpstickermaker/values/colors/my_colors.dart';

class CreateStickerButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CreateStickerButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.width*0.35,
        width: size.width*0.35,
        child: Icon(Icons.add, size: size.width*0.2, color: Colors.white,),
        decoration: BoxDecoration(
          color: MyColors.lowGrey,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
        ),
      ),
    );
  }
}
