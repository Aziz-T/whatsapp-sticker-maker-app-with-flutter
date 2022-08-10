
import 'package:flutter/material.dart';
import 'package:get/get.dart';

p([var tag, var message]){
   print("MESSAGE : ${tag.toString()}------------------------>${message.toString()}");
}


showSnackBar(String message){
   final snackBar = SnackBar(
      backgroundColor: Colors.deepOrangeAccent,
      content:  Text(message),
      action: SnackBarAction(
         label: 'Done',
         textColor: Colors.white,
         onPressed: () {

         },
      ),
      duration: Duration(seconds: 3),
   );

   // Find the ScaffoldMessenger in the widget tree
   // and use it to show a SnackBar.
   ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}