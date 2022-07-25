import 'package:flutter/material.dart';

class StickerInfoForm extends StatelessWidget {
  final TextEditingController? packageNameController;
  final TextEditingController? publisherNameController;
  const StickerInfoForm({Key? key, this.packageNameController, this.publisherNameController,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Package Name",style: TextStyle(fontFamily: 'McLaren'),),
          buildTextFormField(textEditingController: packageNameController),
          SizedBox(height: 10,),
          Text("Package Owner",style: TextStyle(fontFamily: 'McLaren')),
          buildTextFormField(textEditingController: publisherNameController),
        ],
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController? textEditingController, String? hintText}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: textEditingController,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        validator: (val){
          if(val!=null){
            if(val==""){
              return "required";
            }
          }else
          return "required";
        },
      ),
    );
  }
}
