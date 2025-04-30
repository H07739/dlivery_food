import 'package:get/get.dart';
import '../model/admin_model.dart';
import 'package:flutter/material.dart';
import '../function/add_admins.dart';
import '../function/get_admins.dart';
import '../function/updata_admin.dart';

class AddAdminController extends GetxController {
  final admins = <AdminModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdmins();
  }

  Future<void> fetchAdmins() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      
      final adminsList = await getAdmins();
      admins.value = adminsList;
    } catch (error) {
      hasError.value = true;
      errorMessage.value = 'Failed to load admins. Please try again.';
      print('Error fetching admins: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAdmin(AdminModel admin) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      if (!GetUtils.isEmail(admin.email)) {
        throw 'Please enter a valid email address';
      }

      if (admin.name.length < 3) {
        throw 'Name must be at least 3 characters';
      }

      if (admin.restaurantAdmin.isEmpty) {
        throw 'Restaurant is required';
      }

      final updatedAdmin = await updateAdmins(admin: admin);
      
      // Update the admin in the list
      final index = admins.indexWhere((a) => a.id == admin.id);
      if (index != -1) {
        admins[index] = updatedAdmin;
      }

      Get.snackbar(
        'Success',
        'Admin updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAdmin(
      {required String name,
        required String email,
        required String restaurantAdmin,
        required String phone,
        required String address}) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      
      if (!GetUtils.isEmail(email)) {
        throw 'Please enter a valid email address';
      }

      if (name.length < 3) {
        throw 'Name must be at least 3 characters';
      }

      if (restaurantAdmin.isEmpty) {
        throw 'Restaurant is required';
      }

      final admin = await addAdmins(
        email: email,
        name: name,
        restaurantAdmin: restaurantAdmin, phone: phone, address: address,
      );

      admins.add(admin);
      Get.snackbar(
        'Success',
        'Admin added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.1),
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void removeAdmin(int index) {
    try {
      admins.removeAt(index);
      Get.snackbar(
        'Success',
        'Admin removed successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to remove admin',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
} 