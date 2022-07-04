import 'package:flutter/material.dart';

class AddToWhatsapp extends StatelessWidget {
  final VoidCallback? onTap;
  const AddToWhatsapp({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: 45,
        margin: EdgeInsets.only(bottom: 10, top: 5, right: 20, left: 20),
        padding: EdgeInsets.only(bottom: 5, top: 5, right: 20, left: 20),
        decoration: BoxDecoration(
          color: Colors.lightGreen.withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(children: [
          Text(
            "Add to whatsapp",
            style: TextStyle(color: Color.fromRGBO(0, 111, 0, 1.0)),
          ),
          Spacer(),
          Icon(
            Icons.add,
            color: Color.fromRGBO(0, 111, 0, 1.0),
          )
        ]),
      ),
    );
  }
}
