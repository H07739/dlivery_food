import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_admin_controller.dart';
import '../widget/admin_form.dart';
import '../widget/admin_loading_shimmer.dart';
import 'not_found_admins.dart';

class AddAdminView extends StatelessWidget {
  AddAdminView({super.key}) {
    Get.put(AddAdminController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddAdminController>();
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'restaurant Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.green.shade300,
            ],
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const SafeArea(child: AdminLoadingShimmer());
          }

          if (controller.hasError.value) {
            return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.fetchAdmins,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return controller.admins.isEmpty
              ? NotFoundAdmins()
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AdminForm(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
} 