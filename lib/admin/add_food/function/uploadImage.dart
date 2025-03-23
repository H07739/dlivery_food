import 'dart:io';

import 'package:flutter/material.dart';

import '../../../main.dart';

Future<String?> uploadImage({
  required File imageFile,
  required String pathFolder,
  String? url,
  required BuildContext context,
}) async {
  try {
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String path = '$pathFolder/$fileName';

    // إذا كان هناك رابط للصورة القديمة، احذفه
    try{
      if (url != null && url.isNotEmpty) {
        final Uri uri = Uri.parse(url);
        final List<String> segments = uri.pathSegments;
        if (segments.isNotEmpty) {
          final String oldImagePath = segments.sublist(segments.indexOf('image') + 1).join('/');
          await supabase.storage.from('image').remove([oldImagePath]);
          print('🗑️ تم حذف الصورة القديمة: $oldImagePath');
        }
      }
    }
    catch(er){
      print('���️ خطأ أثنا�� حذف الصورة القديمة: $er');
    }


    // رفع الصورة الجديدة إلى Supabase Storage
    await supabase.storage.from('image').upload(path, imageFile);

    // استرجاع رابط الصورة الجديدة
    final String publicUrl = supabase.storage.from('image').getPublicUrl(path);

    print('✅ رابط الصورة الجديدة: $publicUrl');
    return publicUrl;
  } catch (e) {
    print('❌ خطأ أثناء الرفع: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الرفع!')));
    return null;
  }
}
