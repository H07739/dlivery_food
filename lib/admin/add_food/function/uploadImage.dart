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

   // If there is an image, delete it
    try{
      if (url != null && url.isNotEmpty) {
        final Uri uri = Uri.parse(url);
        final List<String> segments = uri.pathSegments;
        if (segments.isNotEmpty) {
          final String oldImagePath = segments.sublist(segments.indexOf('image') + 1).join('/');
          await supabase.storage.from('image').remove([oldImagePath]);
          print('🗑️ The old image has been deleted : $oldImagePath');
        }
      }
    }
    catch(er){
      print('���️ Error while deleting the old image    : $er');
    }


   // upload image to Supabase Storage
    await supabase.storage.from('image').upload(path, imageFile);

    // Retrieve the new image URL
    final String publicUrl = supabase.storage.from('image').getPublicUrl(path);

    print('✅   New image URL: $publicUrl');
    return publicUrl;
  } catch (e) {
    print('❌ Error while uploading  : $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Upload failed!')));
    return null;
  }
}
