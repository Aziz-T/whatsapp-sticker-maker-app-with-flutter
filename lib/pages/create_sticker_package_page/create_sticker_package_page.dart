import 'package:flutter/material.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/create_stickers_button/create_stickers_button.dart';

import '../../values/styles/TextStyles.dart';

class CreateStickerPackage extends StatefulWidget {
  const CreateStickerPackage({Key? key}) : super(key: key);

  @override
  State<CreateStickerPackage> createState() => _CreateStickerPackageState();
}

class _CreateStickerPackageState extends State<CreateStickerPackage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(title: "Create Sticker Package"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildColumn(size),
          SizedBox(height: 15),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(21, (index) {
                return buildCreateStickerButton(size);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn(Size size) {
    return Column(
          children: [
            SizedBox(height: 15),
            Text(
              "Package Icon",
              style: TextStyles.mcLarenStyle,
            ),
            SizedBox(height: 15),
            CreateStickerButton(
              height: size.width * 0.2,
              width: size.width * 0.2,
              iconSize: size.width * 0.13,
            ),
          ],
        );
  }

  Widget buildCreateStickerButton(Size size) {
    return Container(
      padding: EdgeInsets.all(23),
      child: CreateStickerButton(
        // height: size.width * 0.2,
        // width: size.width * 0.2,
        iconSize: size.width * 0.13,
      ),
    );
  }
}
