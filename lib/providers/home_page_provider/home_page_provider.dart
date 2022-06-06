
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wpstickermaker/pages/image_editing_page/image_edit_page.dart';

class HomePageProvider extends ChangeNotifier{

  final ImagePicker _picker = ImagePicker();


  Future<void> getImage() async {
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    Get.to(()=>ImageEditPage());

  }



}