import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/core/functions.dart';
import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/sticker_info_form/sticker_info_form.dart';
import '../../values/styles/TextStyles.dart';
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
            buttonText: "Clear All",
            onPressed: context.read<ImageEditProvider>().imageList.isEmpty
                ? null : () {
              _showMyDialog();
            }),
        body: buildBody(),
        floatingActionButton: Consumer<ImageEditProvider>(builder: (context, snapshot, child) {
          return snapshot.selectedImageList.length < 3
              ? SizedBox.shrink()
              : FloatingActionButton.extended(
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
                    context.read<ImageEditProvider>().clearSelectedList();
                    publisherNameController.clear();
                    packageNameController.clear();
                  }

                }
              },
              label: Text("Add Sticker to Wp",
                  style: TextStyles.mcLarenStyle),
              icon: Icon(Icons.add),
              backgroundColor: Colors.green);
        }),


      ),
    );
  }

  Widget buildBody() {
    return Consumer<ImageEditProvider>(builder: (context, snapshot, child) {
      return snapshot.imageList.isEmpty ?
          Center(child: Text("No Sticker Yet! :)",style: TextStyles.mcLarenStyle),)
          :Column(
        children: [
          StickerInfoForm(
              packageNameController: packageNameController,
              publisherNameController: publisherNameController),
          Text("Select Sticker",style: TextStyles.mcLarenStyle,),
          Expanded(
            child: GridView.count(
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
            ),
          ),
        ],
      );
    });
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          const Text('Clear All', style: TextStyles.mcLarenStyle),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('Clear All', style: TextStyles.mcLarenStyle),
                Text('Do you want to clear all Stickers?',
                    style: TextStyles.mcLarenStyle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: () {
                context.read<ImageEditProvider>().clearAll();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
