
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wpstickermaker/pages/image_editing_page/image_edit_page.dart';

class HomePageProvider extends ChangeNotifier{

  final ImagePicker _picker = ImagePicker();
  String? imagePath;


  Future<void> pickImage() async {
    var imageFile;
    final image = await _picker.pickImage(source: ImageSource.gallery);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    // Capture a photo
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    imagePath = image?.path;
    imagePath = image?.name;

    print(image?.name);
    print(tempPath);
    if(imagePath!=null){
      imageFile = File(image!.path);
      Get.to(()=>ImageEditPage(imagePath: imagePath, image: image));
    }


  }

  Future<void> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imagePath = imageTemporary.path;
      Get.to(()=>ImageEditPage(imagePath: imagePath,image: imageTemporary,));

    } on PlatformException catch (e) {

    }
  }

}