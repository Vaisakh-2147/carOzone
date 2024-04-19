import 'dart:io';

import 'package:car_o_zone/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget customImagePicker({
  required XFile? image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: customBlueColor(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: image != null
            ? Image.file(
                File(image.path),
                fit: BoxFit.cover,
              )
            : const Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 50.0,
                  color: Colors.black,
                ),
              ),
      ),
    ),
  );
}

Widget customAddbrandPicker({
  required String? image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: Container(
        width: 380,
        height: 150,
        decoration: BoxDecoration(
          color: customBlueColor(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: image != null
            ? Image.file(
                File(image),
                fit: BoxFit.cover,
              )
            : const Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 50.0,
                  color: Colors.black,
                ),
              ),
      ),
    ),
  );
}

Widget customUpdatebrandPicker({
  String? networkImage,
  String? fileImage,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: Container(
          width: 380,
          height: 150,
          decoration: BoxDecoration(
            color: customBlueColor(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: fileImage == null
              ? Image.network(
                  networkImage!,
                  fit: BoxFit.cover,
                )
              : Image.file(File(fileImage))),
    ),
  );
}
