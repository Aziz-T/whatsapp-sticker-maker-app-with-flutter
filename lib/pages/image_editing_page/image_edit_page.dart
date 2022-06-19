import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wpstickermaker/pages/add_text_image_page/edit_image_screen.dart';
import 'package:wpstickermaker/values/icons/free_cut_icon_icons.dart';
import 'package:wpstickermaker/widgets/add_text_widget/add_text_widget.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/edit_tool_menu.dart';
import 'package:wpstickermaker/widgets/edit_page_toolmenu/tool_menu_item.dart';

import '../../models/text_info/text_info.dart';
import '../../providers/image_cropper_provider/image_editing_provider.dart';
import '../../widgets/add_text_widgets/default_button.dart';
import '../../widgets/add_text_widgets/image_text.dart';

class ImageEditPage extends StatefulWidget {
  final String? imagePath;
  final image;
  const ImageEditPage({Key? key, this.imagePath, this.image}) : super(key: key);

  @override
  State<ImageEditPage> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {

  bool setText = false;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: setText ? _appBar:MyAppBar(title: "Create Sticker"),
      floatingActionButton: _addnewTextFab,
      body: Container(
        width: size.width,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: size.width,
                    width: size.width,
                    child: context.watch<ImageEditProvider>().val != null
                        ? Image.memory(
                            context.read<ImageEditProvider>().val)
                        : Image.file(widget.image!)),
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          removeText(context);
                        });
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        child: ImageText(textInfo: texts[i]),
                        childWhenDragging: SizedBox.shrink(),
                        onDragEnd: (drag) {
                          final renderBox =
                          context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text(
                    creatorText.text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(
                          0.3,
                        )),
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
            Spacer(),
            EditToolMenu(
              children: [
                ToolMenuItem(
                  iconData: Icons.image_aspect_ratio,
                  onTap: () {
                    context
                        .read<ImageEditProvider>()
                        .cutImage(widget.imagePath!);
                  },
                ),
                ToolMenuItem(
                  iconData: Icons.cut,
                  onTap: () async {
                   await context
                        .read<ImageEditProvider>()
                        .imageCropSquare(widget.imagePath!);
                  },
                ),
                ToolMenuItem(
                  iconData: Icons.text_fields,
                  onTap: () {
                  // Get.to(()=>EditImageScreen(selectedImage: widget.imagePath!));
                   setState(() {
                     setText = !setText;
                   });

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget get _addnewTextFab => FloatingActionButton(
    onPressed: () => addNewDialog(context),
    backgroundColor: Colors.white,
    tooltip: 'Add New Text',
    child: const Icon(
      Icons.edit,
      color: Colors.black,
    ),
  );

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    // await requestPermission(Permission.storage);
    // await ImageGallerySaver.saveImage(bytes, name: name);
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left,
        ),
      );
      Navigator.of(context).pop();
    });
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add New Text',
        ),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
            ),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
            color: Colors.white,
            textColor: Colors.black,
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            child: const Text('Add Text'),
            color: Colors.red,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }



  AppBar get _appBar => AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // IconButton(
            //   icon: const Icon(
            //     Icons.save,
            //     color: Colors.black,
            //   ),
            //   onPressed: () => saveToGallery(context),
            //   tooltip: 'Save Image',
            // ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: increaseFontSize,
              tooltip: 'Increase font size',
            ),
            IconButton(
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
              onPressed: decreaseFontSize,
              tooltip: 'Decrease font size',
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_left,
                color: Colors.black,
              ),
              onPressed: alignLeft,
              tooltip: 'Align left',
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_center,
                color: Colors.black,
              ),
              onPressed: alignCenter,
              tooltip: 'Align Center',
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_right,
                color: Colors.black,
              ),
              onPressed: alignRight,
              tooltip: 'Align Right',
            ),
            IconButton(
              icon: const Icon(
                Icons.format_bold,
                color: Colors.black,
              ),
              onPressed: boldText,
              tooltip: 'Bold',
            ),
            IconButton(
              icon: const Icon(
                Icons.format_italic,
                color: Colors.black,
              ),
              onPressed: italicText,
              tooltip: 'Italic',
            ),
            IconButton(
              icon: const Icon(
                Icons.space_bar,
                color: Colors.black,
              ),
              onPressed: addLinesToText,
              tooltip: 'Add New Line',
            ),
            Tooltip(
              message: 'Red',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'White',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Black',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Blue',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Yellow',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Green',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Orange',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: 'Pink',
              child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ));
}
