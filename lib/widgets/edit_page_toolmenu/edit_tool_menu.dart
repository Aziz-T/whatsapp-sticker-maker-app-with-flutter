import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/image_cropper_provider/image_editing_provider.dart';

class EditToolMenu extends StatelessWidget {
  const EditToolMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
          children: [
            buildMenuItem(
              onTap: (){
                  context.read<ImageEditProvider>().play();
              }
            ),
            buildMenuItem(),
            buildMenuItem(),
            buildMenuItem(),
            buildMenuItem(),
            buildMenuItem(),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({VoidCallback? onTap}) {
    return  InkWell(
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
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
