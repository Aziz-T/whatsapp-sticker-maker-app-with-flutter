// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:whatsapp_stickers/exceptions.dart';
// import 'package:whatsapp_stickers/whatsapp_stickers.dart';
// import 'package:wpstickermaker/providers/image_editing_provider/image_editing_provider.dart';
//
//
// class AppRoot extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('WhatsApp Stickers Flutter Demo'),
//         ),
//         body: Container(
//           child: Column(
//             children: <Widget>[
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 32.0),
//                   child: ElevatedButton(
//                     child: Text('Install from assets'),
//                     onPressed: (){installFromAssets(context);},
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 32.0),
//                   child: Text('Install from remote'),
//                 ),
//               ),
//             ],
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// const stickers = {
//   '01_Cuppy_smile.webp': ['☕', '🙂'],
//   '02_Cuppy_lol.webp': ['😄', '😀'],
//   '03_Cuppy_rofl.webp': ['😆', '😂'],
//   '04_Cuppy_sad.webp': ['😃', '😍'],
//   '05_Cuppy_cry.webp': ['😭', '💧'],
//   '06_Cuppy_love.webp': ['😍', '♥'],
//   '08_Cuppy_lovewithmug.webp': ['😍', '💑'],
//   '09_Cuppy_lovewithcookie.webp': ['😘', '🍪'],
//   '10_Cuppy_hmm.webp': ['🤔', '😐'],
//   '11_Cuppy_upset.webp': ['😱', '😵'],
//   '12_Cuppy_angry.webp': ['😡', '😠'],
//   '13_Cuppy_curious.webp': ['❓', '🤔'],
//   '14_Cuppy_weird.webp': ['🌈', '😜'],
//   '15_Cuppy_bluescreen.webp': ['💻', '😩'],
//   '16_Cuppy_angry.webp': ['😡', '😤'],
//   '17_Cuppy_tired.webp': ['😩', '😨'],
//   '18_Cuppy_workhard.webp': ['😔', '😨'],
// };
//
// Future installFromAssets(BuildContext context) async {
//   var provider = Provider.of<ImageEditProvider>(context, listen: false);
//   var stickerPack = WhatsappStickers(
//     identifier: 'cuppyFlutterWhatsAppStickers',
//     name: 'Cuppy WhatsApp Stickers',
//     publisher: 'John Doe',
//     trayImageFileName: WhatsappStickerImage.fromAsset('assets/stickers/tray_Cuppy1.png'),
//     publisherWebsite: '',
//     privacyPolicyWebsite: '',
//     licenseAgreementWebsite: '',
//   );
//
//
//   stickers.forEach((sticker, emojis) {
//     stickerPack.addSticker(WhatsappStickerImage.fromAsset('assets/stickers/$sticker'), emojis);
//   });
//
//   try {
//     await stickerPack.sendToWhatsApp();
//   } on WhatsappStickersException catch (e) {
//     print(e.cause);
//   }
// }
//
