import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/deneme.dart';
import 'package:wpstickermaker/pages/image_paint_page/image_paint_page.dart';
import 'package:wpstickermaker/providers/main_page_provider/main_page_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/edit_tool_menu.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/tool_menu_item.dart';
import '../../providers/image_editing_provider/image_editing_provider.dart';
import '../image_sticker_page/image_sticker_page.dart';

class ImageEditPage extends StatefulWidget {
  ///image path
  final String? imagePath;

  ///file
  final image;

  const ImageEditPage({Key? key, this.imagePath, this.image}) : super(key: key);

  @override
  State<ImageEditPage> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ImageEditProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: MyAppBar(
              title: "Create Sticker",
              onPressed: () {
                provider.saveImage(provider.val);
                Get.back();
                if(provider.imageList.length <=1) {
                  context.read<MainPageProvider>().setCurrentPage = 1;
                }
                // provider.installFromAssets();
              }),
          body: SizedBox(
            width: size.width,
            child: Column(children: [
              SizedBox(
                  height: size.width,
                  width: size.width,
                  child: provider.val != null
                      ? Image.memory(provider.val)
                      : Image.file(widget.image!)),
              Spacer(),
              EditToolMenu(
                children: [
                  ToolMenuItem(
                    iconData: Icons.image_aspect_ratio,
                    title: "Free Cut",
                    onTap: () {
                      if (widget.imagePath != null) {
                        provider.cutImage(widget.imagePath!, provider.val);
                      }
                    },
                  ),
                  ToolMenuItem(
                    iconData: Icons.cut,
                    title: "Cut",
                    onTap: () async {
                      await provider.imageCropSquare(
                          widget.imagePath!, provider.val, isEdit: true);
                    },
                  ),
                  ToolMenuItem(
                    iconData: Icons.color_lens_outlined,
                    title: "Paint",
                    onTap: () async {
                      Get.to(() => PaintImagePage(
                            image: provider.val,
                          ));
                    },
                  ),
                  ToolMenuItem(
                    iconData: Icons.insert_emoticon,
                    title: "Add Sticker",
                    onTap: () async {
                      Get.to(() => ImageStickerPage(
                            val: provider.val,
                          ));
                    },
                  ),
                ],
              ),
            ]),
          ));
    });
  }
}
