import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/values/icons/free_cut_icon_icons.dart';
import 'package:wpstickermaker/widgets/add_text_widget/add_text_widget.dart';
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
            Container(
                height: size.width,
                width: size.width,
                child: context.watch<ImageEditProvider>().val != null
                    ? Image.memory(
                        context.read<ImageEditProvider>().val)
                    : Image.file(widget.image!)),
            Spacer(),
            AddTextWidget(),
            Spacer(),
            EditToolMenu(
              children: [
                ToolMenuItem(
                  iconData: Icons.image_aspect_ratio,
                  onTap: () {
                    context
                        .read<ImageEditProvider>()
                        .cutImage(widget.imagePath!);
                  },
                ),
                ToolMenuItem(
                  iconData: Icons.cut,
                  onTap: () async {
                   await context
                        .read<ImageEditProvider>()
                        .imageCropSquare(widget.imagePath!);
                  },
                ),
                ToolMenuItem(
                  iconData: Icons.text_fields,
                  onTap: () {

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
