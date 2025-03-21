import 'dart:io';

import 'package:flutter/material.dart';

import '../../../main.dart';

Future<String?> uploadImage({
  required File imageFile,
  required String pathFolder,
  required BuildContext context
}) async {
  try {
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String path = '$pathFolder/$fileName';

    // رفع الصورة إلى Supabase Storage
    await supabase.storage.from('image').upload(path, imageFile);

    // استرجاع رابط الصورة
    final String publicUrl = supabase.storage.from('image').getPublicUrl(path);

    print('✅ رابط الصورة: $publicUrl');
    return publicUrl;
  } catch (e) {
    print('❌ خطأ أثناء الرفع: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الرفع!')));
  }
}