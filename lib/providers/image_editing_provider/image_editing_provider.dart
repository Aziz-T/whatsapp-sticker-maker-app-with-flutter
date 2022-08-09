import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_stickers/exceptions.dart';
import 'package:whatsapp_stickers/whatsapp_stickers.dart';
import 'package:wpstickermaker/core/functions.dart';
import 'package:wpstickermaker/models/image_model/image_model.dart';

import '../../core/storage_manager.dart';
import '../../pages/image_editing_page/image_edit_page.dart';
import '../../values/strings/strings.dart';

class ImageEditProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  ImageModel imageModel = ImageModel();
  List<ImageData> imageList = [];
  List<ImageData> selectedImageList = [];
  final LocalStorage storage = LocalStorage('sticker_app');

  final MethodChannel _channel =
      const MethodChannel('samples.flutter.dev/battery');
  dynamic val;
  dynamic resizedImage;
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
      if(imagePath != null) {
        imageCropSquare(imagePath!, val, file: imageTemporary);
      }



      // Get.to(() => ImageEditPage(
      //       imagePath: imagePath,
      //       image: imageTemporary,
      //     ));
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

  Future<void> resizeImage(dynamic imgByte) async {
    Map<dynamic, Uint8List> map = {"data": imgByte};
    try {
      await _channel.invokeMethod('resize', map).then((value) {
        resizedImage = value;
        resizedImage = Uint8List.fromList(resizedImage);
        log(value.toString());
        p("RESİZED", val);
      });
      // final Image image = Image.memory(val.buffer.asUint8List());
      notifyListeners();
      // return await _channel.invokeMethod('goIntent', map);
    } on PlatformException catch (e) {
      print("invoke method catch: $e");
    }
  }

  Future<void> imageCropSquare(String path, dynamic image,{File? file,bool isEdit = false}) async {
    final buffer = image.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
    File file = await File(filePath).writeAsBytes(
        buffer.asUint8List(image.offsetInBytes, image.lengthInBytes));

    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.green,
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
      if(croppedFile!=null&& isEdit == false){
        Get.to(() => ImageEditPage(
          imagePath: croppedFilePath,
          image: file,
        ));
      }



    } catch (e) {
      print("eeeeeeeeeeee$e");
    }
    notifyListeners();
  }

  var stickers = {
    '01_Cuppy_smile.webp': ['☕', '🙂'],
    '02_Cuppy_lol.webp': ['😄', '😀'],
    '03_Cuppy_rofl.webp': ['😆', '😂'],
    '04_Cuppy_sad.webp': ['😃', '😍'],
    '05_Cuppy_cry.webp': ['😭', '💧'],
    '06_Cuppy_love.webp': ['😍', '♥'],
    '08_Cuppy_lovewithmug.webp': ['😍', '💑'],
    '09_Cuppy_lovewithcookie.webp': ['😘', '🍪'],
    '10_Cuppy_hmm.webp': ['🤔', '😐'],
    '11_Cuppy_upset.webp': ['😱', '😵'],
    '12_Cuppy_angry.webp': ['😡', '😠'],
    '13_Cuppy_curious.webp': ['❓', '🤔'],
    '14_Cuppy_weird.webp': ['🌈', '😜'],
    '15_Cuppy_bluescreen.webp': ['💻', '😩'],
    '16_Cuppy_angry.webp': ['😡', '😤'],
    '17_Cuppy_tired.webp': ['😩', '😨'],
    '18_Cuppy_workhard.webp': ['😔', '😨'],
  };
  var emojis = {
    "0": ['😔', '😨'],
    "1": ['❓', '🤔'],
    "3": ['🤔', '😐'],
    "4": ['😍', '💑'],
    "5": ['😆', '😂'],
    "6": ['😍', '♥'],
    "7": ['😍', '💑'],
    "8": ['😘', '🍪'],
  };

  Future<void> saveImage(dynamic imageData) async {
    await resizeImage(imageData);
    var resized = resizedImage;
    final result = await FlutterImageCompress.compressWithList(
      resized,
      minHeight: 512,
      minWidth: 512,
      quality: 80,
      format: CompressFormat.webp,
    );
    final buffer = result.buffer;
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/${DateTime.now().minute}${DateTime.now().microsecond}.webp'; // file_01.tmp is dump file, can be anything
    File file = await File(filePath).writeAsBytes(
        buffer.asUint8List(result.offsetInBytes, result.lengthInBytes));
    imageList.add(ImageData(imagePath: file.path));
    imageModel.data = imageList;
    await storage.setItem('images', imageModel.toJson());
    notifyListeners();
    p("saved image", file.path);
    p("saved image", file);
    GallerySaver.saveImage(file.path).then((value) {
      print(value.toString());
    });
  }

  Future<void> setSelected(int index, bool val) async {
    imageList[index].isSelected = val;
    p("selected Image", imageList[index].imagePath);
    selectedImageList.add(imageList[index]);
    p("selected Image list size ", selectedImageList.length);
    notifyListeners();
  }

  Future<void> getImageList() async {
    await storage.ready;
    var items = await storage.getItem('images');
    if (items != null) {
      imageModel = ImageModel.fromJson(items);
      imageList = imageModel.data ?? [];
    }

    p("GET ITEMSSS", items.toString());

    notifyListeners();
  }

  Future<void> clearAll() async {
    await storage.ready;
    await storage.clear();
    imageList.clear();
    notifyListeners();
  }

  Future<void> addToWhatsapp(
      {required String packageName, required String publisherName}) async {
    if (selectedImageList.isNotEmpty) {
      var stickerPack = WhatsappStickers(
        identifier: packageName,
        name: packageName,
        publisher: publisherName,
        trayImageFileName:
            WhatsappStickerImage.fromAsset('assets/stickers/tray_Cuppy1.png'),
      );

      selectedImageList.asMap().forEach((key, element) {
        p("per element for add", element);
        stickerPack.addSticker(
            WhatsappStickerImage.fromFile(element.imagePath ?? ""),
            emojis["$key"] ?? ['😍', '♥']);
      });
      try {
        p("STICKER PACK", stickerPack.trayImageFileName.path.toString());
        p("STICKER PACK", stickerPack.identifier.toString());
        await stickerPack.sendToWhatsApp();
      } on WhatsappStickersException catch (e) {
        p("EEEEEEEE", e.cause);
      }
    }
  }
}
