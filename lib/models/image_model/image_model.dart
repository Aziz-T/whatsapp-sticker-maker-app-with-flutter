// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    this.data,
  });

  List<ImageData>? data;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    data: List<ImageData>.from(json["data"].map((x) => ImageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data !=null ? List<dynamic>.from(data!.map((x) => x.toJson())):[],
  };
}

class ImageData {
  ImageData({
    this.imagePath,
    this.isSelected,
    this.isDeleted
  });

  String? imagePath;
  bool? isSelected;
  bool? isDeleted;

  setFalse(){
    isSelected = false;
  }


  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    imagePath: json["imagePath"],
    isSelected: json["isSelected"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "isSelected": isSelected,
    "isDeleted": isDeleted,
  };
}
