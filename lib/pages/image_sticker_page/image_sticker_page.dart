import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';

import '../../core/packages/simple_sticker_image/flutter_simple_sticker_view.dart';

class ImageStickerPage extends StatefulWidget {
  final dynamic val;
  const ImageStickerPage({Key? key, this.val}) : super(key: key);

  @override
  State<ImageStickerPage> createState() => _ImageStickerPageState();
}

class _ImageStickerPageState extends State<ImageStickerPage> {
  late FlutterSimpleStickerView _stickerView;

  @override
  void initState() {
    // TODO: implement initState
    _stickerView = FlutterSimpleStickerView(
      Image.memory(widget.val),
      // Container(
      //   // height: size.width,
      //   // width: size.width,
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       image: DecorationImage(
      //           image: MemoryImage(widget.val))),
      // ),
      [
        Image.asset("assets/impo.png"),
        Image.asset("assets/image_stickers/3d-glasses.png"),
        Image.asset("assets/image_stickers/baby-clothing.png"),
        Image.asset("assets/image_stickers/balloon.png"),
        Image.asset("assets/image_stickers/balloons.png"),
        Image.asset("assets/image_stickers/baseball-hat.png"),
        Image.asset("assets/image_stickers/beanie.png"),
        Image.asset("assets/image_stickers/beret.png"),
        Image.asset("assets/image_stickers/best-friends.png"),
        Image.asset("assets/image_stickers/cellular-phone.png"),
        Image.asset("assets/image_stickers/chef-hat.png"),
        Image.asset("assets/image_stickers/comet.png"),
        Image.asset("assets/image_stickers/devil.png"),
        Image.asset("assets/image_stickers/dress.png"),
        Image.asset("assets/image_stickers/excited.png"),
        Image.asset("assets/image_stickers/eyeglases.png"),
        Image.asset("assets/image_stickers/eyeglasses.png"),
        Image.asset("assets/image_stickers/gold-star.png"),
        Image.asset("assets/image_stickers/graduate-hat.png"),
        Image.asset("assets/image_stickers/happy.png"),
        Image.asset("assets/image_stickers/hard-hat.png"),
        Image.asset("assets/image_stickers/hat-and-glasses.png"),
        Image.asset("assets/image_stickers/in-love.png"),
        Image.asset("assets/image_stickers/laptop.png"),
        Image.asset("assets/image_stickers/lip.png"),
        Image.asset("assets/image_stickers/lov.png"),
        Image.asset("assets/image_stickers/love.png"),
        Image.asset("assets/image_stickers/love-you.png"),
        Image.asset("assets/image_stickers/pamela-hat.png"),
        Image.asset("assets/image_stickers/party-glasses.png"),
        Image.asset("assets/image_stickers/party-hat.png"),
        Image.asset("assets/image_stickers/sad.png"),
        Image.asset("assets/image_stickers/shirt.png"),
        Image.asset("assets/image_stickers/star.png"),
        Image.asset("assets/image_stickers/sun-hat.png"),
        Image.asset("assets/image_stickers/surprised.png"),
        Image.asset("assets/image_stickers/wedding.png"),
        Image.asset("assets/image_stickers/wine.png"),
        Image.asset("assets/image_stickers/wizard.png"),
      ],
      // panelHeight: 150,
      panelBackgroundColor: Colors.white,
      panelStickerBackgroundColor: Colors.white,
      // panelStickercrossAxisCount: 4,
      // panelStickerAspectRatio: 1.0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
          title: "Sticky Image",
          onPressed: () async {
            Future<Uint8List?> image = await _stickerView.exportImage();
            Uint8List? byteArray = await image;
            await context.read<ImageEditProvider>().setVal(byteArray);
            Get.back();
          }),
      body: _stickerView,
    );
  }
}
