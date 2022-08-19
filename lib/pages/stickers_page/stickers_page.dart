import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:wpstickermaker/core/functions.dart';
import 'package:wpstickermaker/widgets/add_to_whatsapp_button/add_to_whatsapp_button.dart';

import '../../providers/image_editing_provider/image_editing_provider.dart';
import '../../widgets/app_bar/my_app_bar.dart';
import '../../widgets/saved_image_item/saved_image_item.dart';
import '../add_to_whatsapp_page/add_to_whatsapp_page.dart';

class StickersPage extends StatefulWidget {
  const StickersPage({Key? key}) : super(key: key);

  @override
  State<StickersPage> createState() => _StickersPageState();
}

class _StickersPageState extends State<StickersPage> {
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: "Stickers List",
          buttonText: "Clear All",
          onPressed: () {
            _showMyDialog();
          }),
      body: Column(
        children: [
          // AddToWhatsapp(
          //   onTap: () {
          //     Get.to(()=>const AddToWhatsappPage());
          //     // context.read<ImageEditProvider>().addToWhatsapp();
          //   },
          // ),
          Expanded(
            child: Consumer<ImageEditProvider>(builder: (context, snapshot, _) {
              return snapshot.imageList.isEmpty ? Center(child: Text("No Sticker Yet :)",style: TextStyle(fontFamily: 'McLaren')),) : GridView.count(
                crossAxisCount: 2,
                children: List.generate(snapshot.imageList.length, (index) {
                  return SavedImageItem(
                    filePath: snapshot.imageList[index].imagePath,
                    isDelete: snapshot.imageList[index].isDeleted??false,
                    onDeleteTap: (){
                      snapshot.deleteData(index);
                    },
                    onTap: () {
                      if (snapshot.imageList[index].isDeleted == null) {
                        snapshot.selectDeletedData(index, true);
                      } else {
                        snapshot.selectDeletedData(
                            index, !snapshot.imageList[index].isDeleted!);
                      }
                    },
                  );
                }),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if(context.read<ImageEditProvider>().imageList.length<4) {
              showSnackBar("You must create at least 4 stickers!");
            }else {
              Get.to(() => const AddToWhatsappPage());
            }
          },
          label: Text("Add Sticker to Wp",
              style: TextStyle(fontFamily: 'McLaren')),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Text('Clear All', style: TextStyle(fontFamily: 'McLaren')),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('Clear All', style: TextStyle(fontFamily: 'McLaren')),
                Text('Do you want to clear all Stickers?',
                    style: TextStyle(fontFamily: 'McLaren')),
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
