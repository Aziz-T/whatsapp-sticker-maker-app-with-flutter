import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageEditProvider extends ChangeNotifier {
   final MethodChannel _channel = const MethodChannel('samples.flutter.dev/battery');
    dynamic val;
   Future<void> cutImage(String image) async {

     File imagefile = File(image); //convert Path to File
     Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
     // String base64string = base64.encode(imagebytes);

    // String audioasset = "assets/img.jpg"; //path to asset
    // ByteData bytes = await rootBundle.load(image); //load sound from assets
    // Uint8List soundbytes =
    //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    //
    Map<dynamic, Uint8List> map = {"data": imagebytes};
    try {
       await _channel.invokeMethod('goIntent', map).then((value) {
         val = value;
         log(value.toString());
       });
      // final Image image = Image.memory(val.buffer.asUint8List());
      notifyListeners();
      // return await _channel.invokeMethod('goIntent', map);
    } on PlatformException catch (e) {}
  }

  Future<void> imageToBtye() async {




  }
}
