import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_admin_controller.dart';
import '../function/showAddAdminDialog.dart';
import 'item_admin.dart';

class AdminForm extends StatelessWidget {
  const AdminForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddAdminController>();

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white.withOpacity(0.15),
          child: InkWell(
            onTap: () => showAddAdminDialog(context),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add New Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.admins.length,
          itemBuilder: (context, index) {
            final admin = controller.admins[index];
            return ItemAdmin(admin: admin, controller: controller, index: index,);
          },
        )),
      ],
    );
  }
} 