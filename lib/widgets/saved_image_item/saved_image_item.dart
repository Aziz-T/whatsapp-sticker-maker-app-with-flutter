import 'dart:io';

import 'package:flutter/material.dart';

class SavedImageItem extends StatefulWidget {
  final String? filePath;
  final bool isSelected;
  final VoidCallback? onTap;
  const SavedImageItem({Key? key, this.filePath, this.isSelected=false, this.onTap}) : super(key: key);

  @override
  State<SavedImageItem> createState() => _SavedImageItemState();
}

class _SavedImageItemState extends State<SavedImageItem> {
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.filePath!=null) {
      file = File(widget.filePath!);
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: widget.isSelected ? Border.all(color: Colors.blue,width: 2):null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: file!=null ? Image.file(file!):const SizedBox(),
      ),
    );
  }
}
