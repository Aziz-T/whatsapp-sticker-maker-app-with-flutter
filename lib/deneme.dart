/*


  pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageTemporary.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: AppStrings.cutImage,
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      imageFile = croppedFile;
      imagePath = croppedFile?.path;
      notifyListeners();
      log(imagePath??"null");
    } on PlatformException catch (e) {
      p("GALLERY HATASI", e);
    }
  }

  pickCamera(BuildContext context) async {
    try {
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if (photo == null) return;
      final imageTemporary = File(photo.path);
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageTemporary.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: AppStrings.cutImage,
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      imageFile = croppedFile;
      notifyListeners();
    } on PlatformException catch (e) {
      p("Camera HATASI", e);
    }
  }
Future<void> saveScreenshot(Uint8List pngBytes) async {


  // await requestPermission();

  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  final info = statuses[Permission.storage];
  p("info", info);
  if(info==PermissionStatus.granted){
    try {
      //extract bytes
      //create file
      final String dir = (await getExternalStorageDirectory())!.path;
      final String fullPath = '$dir/${"img"}.jpg';
      File capturedFile = File(fullPath);
      await capturedFile.writeAsBytes(pngBytes);
      p("PATH", capturedFile.path);
      GallerySaver.saveImage(capturedFile.path).then((value) async {

        FlutterShare.shareFile(
            title: 'Revel Move Story',
            filePath: capturedFile.path,
            fileType: 'image/jpg'
        );
      });
    } catch (e) {
      p("ERROR",e.toString());
    }
  }else {
    out("red");
  }



  }




 */