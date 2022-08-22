import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/values/styles/TextStyles.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/create_stickers_button/create_stickers_button.dart';

import '../../core/functions.dart';
import '../../widgets/saved_image_item/saved_image_item.dart';
import '../add_to_whatsapp_page/add_to_whatsapp_page.dart';

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
      appBar: MyAppBar(title: "Home Page", fontSize: 20,onPressed: (){
        showSnackBar("You must create at least 3 Stickers!");
      },buttonChild: Icon(Icons.error_outline)),
      body: buildNoStickerView(context),
      // floatingActionButton: context.read<ImageEditProvider>().imageList.isEmpty
      //     ? null
      //     : FloatingActionButton.extended(
      //         onPressed: () {
      //           if (context.read<ImageEditProvider>().imageList.length < 3) {
      //             showSnackBar("You must create at least 3 stickers!");
      //           } else {
      //             Get.to(() => const AddToWhatsappPage());
      //           }
      //         },
      //         label: Text("Add Sticker to Wp",
      //             style: TextStyle(
      //               fontFamily: 'McLaren',
      //             )),
      //         icon: Icon(Icons.add),
      //         backgroundColor: Colors.green),
    );
  }

  // Widget homePageBody(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return SizedBox(
  //     width: size.width,
  //     child: Column(
  //       children: [
  //         buildTopColumn(size, context),
  //         Expanded(
  //           child: Consumer<ImageEditProvider>(builder: (context, snapshot, _) {
  //             return GridView.count(
  //               crossAxisCount: 3,
  //               children: List.generate(snapshot.imageList.length, (index) {
  //                 return SavedImageItem(
  //                   filePath: snapshot.imageList[index].imagePath,
  //                   isDelete: snapshot.imageList[index].isDeleted ?? false,
  //                   onDeleteTap: () {
  //                     snapshot.deleteData(index);
  //                   },
  //                   onTap: () {
  //                     if (snapshot.imageList[index].isDeleted == null) {
  //                       snapshot.selectDeletedData(index, true);
  //                     } else {
  //                       snapshot.selectDeletedData(
  //                           index, !snapshot.imageList[index].isDeleted!);
  //                     }
  //                   },
  //                 );
  //               }),
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Column buildTopColumn(Size size, BuildContext context) {
  //   return Column(
  //     children: [
  //       SizedBox(height: 25),
  //       CreateStickerButton(
  //         height: size.width * 0.2,
  //         width: size.width * 0.2,
  //         color: Colors.greenAccent,
  //         iconSize: size.width * 0.14,
  //         onTap: () {
  //           context.read<ImageEditProvider>().getImage();
  //         },
  //       ),
  //       SizedBox(height: 15),
  //       buildText("Create a Sticker!"),
  //       SizedBox(height: 15),
  //       SizedBox(height: 15),
  //     ],
  //   );
  // }

  Center buildNoStickerView(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          CreateStickerButton(
            color: Colors.greenAccent,
            onTap: () {
              context.read<ImageEditProvider>().getImage();
            },
          ),
          SizedBox(
            height: 12,
          ),
          buildText("Press button and create a sticker!"),
          Expanded(
            child: Consumer<ImageEditProvider>(builder: (context, snapshot, _) {
              return Column(
                children: [
                  snapshot.imageList.isEmpty ? SizedBox.shrink() : Spacer(),
                  snapshot.imageList.isEmpty
                      ? SizedBox.shrink()
                      : Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            buildHistoryText(),
                          ],
                        ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.imageList.length,
                        itemBuilder: (context, index) {
                          return buildSavedImageItem(
                              snapshot.imageList[index].imagePath ?? "");
                        }),
                  ),
                ],
              );
            }),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget buildSavedImageItem(String path) {
    File file = File(path);
    return Container(
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        // borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 0.5,
        //     blurRadius: 1,
        //     offset: Offset(0, 1), // changes position of shadow
        //   ),
        // ]
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Image.file(file),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: TextStyles.mcLarenStyle.copyWith(
          fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Text buildHistoryText() {
    return Text(
      "Sticker History",
      textAlign: TextAlign.start,
      style:  TextStyles.mcLarenStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
