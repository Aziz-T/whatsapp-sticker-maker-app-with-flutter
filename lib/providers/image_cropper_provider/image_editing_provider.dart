import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../pages/image_editing_page/image_edit_page.dart';

class ImageEditProvider extends ChangeNotifier {

  final ImagePicker _picker = ImagePicker();
  String? imagePath;


  final MethodChannel _channel =
      const MethodChannel('samples.flutter.dev/battery');
  dynamic val;
  dynamic mainImage;

  setVal(dynamic img) {
    val = img;
    notifyListeners();
  }


  Future<void> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imagePath = imageTemporary.path;
      val = await imageTemporary.readAsBytes();
      Get.to(()=>ImageEditPage(imagePath: imagePath,image: imageTemporary,));

    } on PlatformException catch (e) {
            print("catcheeeeeeee$e");
    }
  }


  ///bu bizim temel imagemiz Uint8 olarak güncelliyoruz her seferinde
  String? croppedFilePath;
  Future<void> cutImage(String image, dynamic imgByte) async {
    File imagefile = File(image); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes

    Map<dynamic, Uint8List> map = {"data": imgByte};
    try {
      await _channel.invokeMethod('goIntent', map).then((value) {
        val = value;
        val = Uint8List.fromList(val);
        log(value.toString());
      });
      // final Image image = Image.memory(val.buffer.asUint8List());
      notifyListeners();
      // return await _channel.invokeMethod('goIntent', map);
    } on PlatformException catch (e) {
      print("invoke method catch: $e");
    }
  }

  Future<void> imageCropSquare(String path, dynamic image) async {
    final buffer = image.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
    File file = await File(filePath)
        .writeAsBytes(buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));

    try{
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      croppedFilePath = croppedFile?.path;
      val = await croppedFile?.readAsBytes() as Uint8List;
    }catch(e){
      print("eeeeeeeeeeee$e");
    }
    notifyListeners();
  }

  Future<void> saveImage(dynamic imageData)async {
    print("SAVE Image");
    final buffer = imageData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
    File file = await File(filePath)
        .writeAsBytes(buffer.asUint8List(imageData.offsetInBytes, imageData.lengthInBytes));

    GallerySaver.saveImage(file.path).then((value) {
      print(value.toString());
    });
  }

}
