import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/setting/function/get_admin_data.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

import '../model/admin_model.dart';

class SettingController extends GetxController {
  final nameController = TextEditingController();
  final restaurantController = TextEditingController();
  var isLoading = false.obs;
  var admin = Rxn<AdminModel>();

  @override
  void onInit() {
    super.onInit();
    loadAdminData();
  }

  Future<void> loadAdminData() async {
    try {
      isLoading.value = true;
      admin.value = (await getAdminData()) as AdminModel?;
      nameController.text = admin.value?.name ?? '';
      restaurantController.text = admin.value?.restaurantAdmin ?? '';
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to load admin data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAdminData() async {
    try {
      isLoading.value = true;
      await supabase.from(Table_Admins).update({
        'name': nameController.text,
        'restaurant_admin': restaurantController.text,
      }).eq('uuid', supabase.auth.currentUser!.id);

      await loadAdminData();
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    restaurantController.dispose();
    super.onClose();
  }
}
