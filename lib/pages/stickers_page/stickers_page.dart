import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
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
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: "Stickers List", buttonText: "Clear", onPressed: () {
            context.read<ImageEditProvider>().clearAll();
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
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(snapshot.imageList.length, (index) {
                  return SavedImageItem(
                    filePath: snapshot.imageList[index].imagePath,
                    isSelected: isSelected,
                    onTap: () {

                    },
                  );
                }),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {Get.to(()=>const AddToWhatsappPage());},
          label: Text("Add Sticker to Wp", style: TextStyle(fontFamily: 'McLaren')),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green),
    );
  }
}
