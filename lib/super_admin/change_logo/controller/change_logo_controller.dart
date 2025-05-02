import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main.dart';
import '../../../strings.dart';

class ChangeLogoController extends GetxController {
  final selectedImage = Rxn<XFile>();
  final isLoading = false.obs;


  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.white,
      );
    }
  }

  Future<void> uploadLogo() async {
    if (selectedImage.value == null) return;

    try {
      isLoading.value = true;

      // محاولة جلب الشعار القديم
      final settings = await supabase
          .from(Table_Seteing)
          .select('logo_url')
          .eq('id', 1)
          .maybeSingle();

      String? oldLogoPath;
      if (settings != null && settings['logo_url'] != null) {
        final url = settings['logo_url'] as String;
        final uri = Uri.parse(url);
        oldLogoPath = uri.pathSegments.last;
      }

      // تجهيز الملف الجديد
      final file = File(selectedImage.value!.path);
      final fileExt = selectedImage.value!.path.split('.').last;
      final fileName = 'logo_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'logos/$fileName';

      // رفع الشعار الجديد
      await supabase.storage.from('image').upload(filePath, file);

      // حذف الشعار القديم إن وجد
      if (oldLogoPath != null && oldLogoPath.isNotEmpty) {
        try {
          await supabase.storage.from('image').remove(['logos/$oldLogoPath']);
        } catch (e) {
          print('Error deleting old logo: $e');
        }
      }

      // رابط الشعار الجديد
      final imageUrl = supabase.storage.from('image').getPublicUrl(filePath);

      // تحديث الرابط في قاعدة البيانات
      await supabase.from(Table_Seteing).update({'logo_url': imageUrl}).eq('id', 1);

      // إشعار المستخدم
      Get.snackbar(
        'Success',
        'Logo updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.white,
      );

      // مسح الصورة المختارة
      clearSelectedImage();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload logo: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }





  void clearSelectedImage() {
    selectedImage.value = null;
  }



} 