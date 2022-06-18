import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageEditProvider extends ChangeNotifier {
   final MethodChannel _channel = const MethodChannel('samples.flutter.dev/battery');
    dynamic val;
    String? croppedFilePath;
   Future<void> cutImage(String image) async {

     File imagefile = File(image); //convert Path to File
     Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes

    Map<dynamic, Uint8List> map = {"data": imagebytes};
    try {
       await _channel.invokeMethod('goIntent', map).then((value) {
         val = value;
         val = Uint8List.fromList(
             val);
         log(value.toString());
       });
      // final Image image = Image.memory(val.buffer.asUint8List());
      notifyListeners();
      // return await _channel.invokeMethod('goIntent', map);
    } on PlatformException catch (e) {}
  }

  Future<void> imageCropSquare(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
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

    notifyListeners();
  }
}
