import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageEditProvider extends ChangeNotifier {
   final MethodChannel _channel = const MethodChannel('samples.flutter.dev/battery');

   Future<void> play() async {
    String audioasset = "assets/img.jpg"; //path to asset
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    Map<dynamic, Uint8List> map = {"data": soundbytes};
    try {
      return await _channel.invokeMethod('goIntent', map);
    } on PlatformException catch (e) {}
  }
}
