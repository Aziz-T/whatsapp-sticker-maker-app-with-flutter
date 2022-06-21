import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wpstickermaker/pages/image_paint_page/image_paint_page.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/edit_tool_menu.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/tool_menu_item.dart';

import '../../models/text_info/text_info.dart';
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
      appBar: MyAppBar(title: "Create Sticker", onPressed: () {}),
      body: Container(
        width: size.width,
        child: Column(children: [
          SizedBox(
              height: size.width,
              width: size.width,
              child: context.watch<ImageEditProvider>().val != null
                  ? Image.memory(context.read<ImageEditProvider>().val)
                  : Image.file(widget.image!)),
          Spacer(),
          EditToolMenu(
            children: [
              ToolMenuItem(
                iconData: Icons.image_aspect_ratio,
                onTap: () {
                  context.read<ImageEditProvider>().cutImage(widget.imagePath!);
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
                iconData: Icons.color_lens_outlined,
                onTap: () async {
                  Get.to(() => PaintImagePage(
                        image: widget.image,
                      ));
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}
