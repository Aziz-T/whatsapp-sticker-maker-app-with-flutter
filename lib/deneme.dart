// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
//
// import 'core/packages/simple_sticker_image/flutter_simple_sticker_view.dart';
//
// class Deneme extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: "Flutter Simple Sticker View", home: HomeView());
//   }
// }
//
// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   FlutterSimpleStickerView _stickerView = FlutterSimpleStickerView(
//     Container(
//       decoration: BoxDecoration(
//           color: Colors.red,
//           image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(
//                   "https://images.unsplash.com/photo-1544032527-042957c6f7ce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"))),
//     ),
//     [
//       Image.asset("assets/stickers/tray_Cuppy.png"),
//       Image.asset("assets/stickers/tray_Cuppy1.png"),
//       Image.asset("assets/impo.png"),
//
//     ],
//     // panelHeight: 150,
//     // panelBackgroundColor: Colors.blue,
//     // panelStickerBackgroundColor: Colors.pink,
//     // panelStickercrossAxisCount: 4,
//     // panelStickerAspectRatio: 1.0,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter Simple Sticker View"),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.save_alt),
//               onPressed: () async {
//                 // Uint8List image = (await _stickerView.exportImage()) as Uint8List;
//                 //
//                 // Map<PermissionGroup, PermissionStatus> permissions =
//                 // await PermissionHandler()
//                 //     .requestPermissions([PermissionGroup.storage]);
//                 // await ImageGallerySaver.saveImage(image);
//               },
//             )
//           ],
//         ),
//         body: _stickerView);
//   }
// }