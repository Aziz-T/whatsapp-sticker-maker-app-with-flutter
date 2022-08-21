import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/core/functions.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/sticker_info_form/sticker_info_form.dart';

import '../../widgets/create_stickers_button/create_stickers_button.dart';
import '../../widgets/saved_image_item/saved_image_item.dart';

class AddToWhatsappPage extends StatefulWidget {
  const AddToWhatsappPage({Key? key}) : super(key: key);

  @override
  State<AddToWhatsappPage> createState() => _AddToWhatsappPageState();
}

class _AddToWhatsappPageState extends State<AddToWhatsappPage> {
  final _key = GlobalKey<FormState>();
  late TextEditingController packageNameController;
  late TextEditingController publisherNameController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageNameController = TextEditingController();
    publisherNameController = TextEditingController();
    context.read<ImageEditProvider>().selectedImageList.clear();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<ImageEditProvider>().clearSelectedList();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    packageNameController.dispose();
    publisherNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Scaffold(
        appBar: MyAppBar(
            title: "Create Sticker Package",
            fontSize: 16,
            buttonText: "Done",
            onPressed: () async {
              if (_key.currentState!.validate()) {
                if(context.read<ImageEditProvider>().selectedImageList.length<3){
                  showSnackBar("Select at least 3 stickers.");
                }else {
                  await context.read<ImageEditProvider>().addToWhatsapp(
                      packageName: packageNameController.text,
                      publisherName: publisherNameController.text
                  );
                  context.read<ImageEditProvider>().selectedImageList.clear();
                }

              }
            }),
        body: Column(
          children: [
            StickerInfoForm(
                packageNameController: packageNameController,
                publisherNameController: publisherNameController),
            Expanded(child: buildSelectionList())
          ],
        ),
      ),
    );
  }

  Widget buildSelectionList() {
    return Consumer<ImageEditProvider>(builder: (context, snapshot, child) {
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(snapshot.imageList.length, (index) {
          return SavedImageItem(
            filePath: snapshot.imageList[index].imagePath,
            isSelected: snapshot.imageList[index].isSelected ?? false,
            onTap: () {
              if (snapshot.imageList[index].isSelected == null) {
                snapshot.setSelected(index, true);
              } else {
                snapshot.setSelected(
                    index, !snapshot.imageList[index].isSelected!);
              }
            },
          );
        }),
      );
    });
  }
}
