import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
final ImagePicker _picker = ImagePicker();
Future<File?> pickImage({required ValueNotifier<bool> imageSelect}) async {
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    imageSelect.value = true;
    return File(pickedFile.path);

  }
  else{
    imageSelect.value = false;
  }
}