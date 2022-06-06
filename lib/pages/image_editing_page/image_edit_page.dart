import 'package:flutter/material.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/edit_tool_menu.dart';

class ImageEditPage extends StatefulWidget {
  const ImageEditPage({Key? key}) : super(key: key);

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
            Container(height: size.width, width: size.width, color: Colors.red),
            Spacer(),
            EditToolMenu()
          ],
        ),
      ),
    );
  }
}
