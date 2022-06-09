import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/edit_tool_menu.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/tool_menu_item.dart';

import '../../providers/image_cropper_provider/image_editing_provider.dart';

class ImageEditPage extends StatefulWidget {
  final String? imagePath;
  final image;
  const ImageEditPage({Key? key, this.imagePath, this.image}) : super(key: key);

  @override
  State<ImageEditPage> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(title: "Create Sticker"),
      body: Container(
        width: size.width,
        child: Column(
          children: [
            Container(height: size.width, width: size.width,
            child: Image.file(widget.image!)),
            Spacer(),
            EditToolMenu(
              children: [
                ToolMenuItem(onTap: (){
                  context.read<ImageEditProvider>().cutImage(widget.imagePath!);
                },)
              ],
            )
          ],
        ),
      ),
    );
  }

}
