// import 'package:flutter/material.dart';
//
// import '../../widgets/app_bar/my_app_bar.dart';
// import '../../widgets/saved_image_item/saved_image_item.dart';
//
// class StorePage extends StatefulWidget {
//   const StorePage({Key? key}) : super(key: key);
//
//   @override
//   State<StorePage> createState() => _StorePageState();
// }
//
// class _StorePageState extends State<StorePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//           title: "Stickers",),
//       body: Column(
//         children: [
//           // AddToWhatsapp(
//           //   onTap: () {
//           //     Get.to(()=>const AddToWhatsappPage());
//           //     // context.read<ImageEditProvider>().addToWhatsapp();
//           //   },
//           // ),
//           Expanded(
//             child: GridView.count(
//                 crossAxisCount: 2,
//                 children: List.generate(snapshot.imageList.length, (index) {
//                   return SavedImageItem(
//                     filePath: snapshot.imageList[index].imagePath,
//                     isSelected: isSelected,
//                     onTap: () {},
//                   );
//                 }),
//               );
//             }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             if(context.read<ImageEditProvider>().imageList.length<4) {
//               showSnackBar("You must create at least 4 stickers!");
//             }else {
//               Get.to(() => const AddToWhatsappPage());
//             }
//           },
//           label: Text("Add Sticker to Wp",
//               style: TextStyles.mcLarenStyle),
//           icon: Icon(Icons.add),
//           backgroundColor: Colors.green),
//     );
//   }
// }
