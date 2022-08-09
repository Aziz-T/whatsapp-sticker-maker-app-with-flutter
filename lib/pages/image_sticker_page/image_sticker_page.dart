import 'package:flutter/material.dart';

import '../../core/packages/simple_sticker_image/flutter_simple_sticker_view.dart';

class ImageStickerPage extends StatefulWidget {
  const ImageStickerPage({Key? key}) : super(key: key);

  @override
  State<ImageStickerPage> createState() => _ImageStickerPageState();
}

class _ImageStickerPageState extends State<ImageStickerPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterSimpleStickerView(
      Container(
        decoration: const BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1544032527-042957c6f7ce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"))),
      ),
      [
        Image.asset("assets/stickers/tray_Cuppy.png"),
        Image.asset("assets/stickers/tray_Cuppy1.png"),
        Image.asset("assets/impo.png"),

      ],
      // panelHeight: 150,
      // panelBackgroundColor: Colors.blue,
      // panelStickerBackgroundColor: Colors.pink,
      // panelStickercrossAxisCount: 4,
      // panelStickerAspectRatio: 1.0,
    );

  }
}
