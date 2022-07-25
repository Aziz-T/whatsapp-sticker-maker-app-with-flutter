import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/create_stickers_button/create_stickers_button.dart';

import '../../widgets/saved_image_item/saved_image_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<ImageEditProvider>().getImageList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const MyAppBar(title: "Home Page",fontSize: 20),
      body: homePageBody(context),
    );
  }

  Widget homePageBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          CreateStickerButton(
            onTap: () {
              context.read<ImageEditProvider>().getImage();
            },
          ),
          SizedBox(
            height: 12,
          ),
          buildText(),
          Spacer(),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              buildHistoryText(),
            ],
          ),
          Expanded(
            child: Consumer<ImageEditProvider>(
              builder: (context, snapshot, _) {
                return ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.imageList.length,
                    itemBuilder: (context, index){
                  return SavedImageItem(
                      filePath: snapshot.imageList[index].imagePath,
                  );
                });
              }
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Text buildText() {
    return Text(
      "Let's create a sticker!",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'McLaren'),
    );
  }

  Text buildHistoryText() {
    return Text(
      "Sticker History",
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'McLaren',
      ),
    );
  }
}
