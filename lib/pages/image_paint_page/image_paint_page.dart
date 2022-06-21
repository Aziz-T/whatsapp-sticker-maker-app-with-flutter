import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:wpstickermaker/widgets/app_bar/my_app_bar.dart';

class PaintImagePage extends StatefulWidget {
  final image;
  const PaintImagePage({Key? key, this.image}) : super(key: key);

  @override
  State<PaintImagePage> createState() => _PaintImagePageState();
}

class _PaintImagePageState extends State<PaintImagePage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ImagePainter.file(
            widget.image!,
            key: _imageKey,
            scalable: true,
            initialStrokeWidth: 2,
            textDelegate: TextDelegate(),
            initialColor: Colors.green,
            initialPaintMode: PaintMode.line,
          ),
        ),
    );
  }
}
