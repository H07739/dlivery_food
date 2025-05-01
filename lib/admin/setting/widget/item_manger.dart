import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/admin/setting/function/delete_manger.dart';
import 'package:my_project/admin/setting/function/updata_name.dart';

import '../model/manger_model.dart';

class ItemManger extends StatelessWidget {
  ItemManger({super.key, required this.model, required this.controller});
  final MangerModel model;
  final MangerController controller;

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: model.name);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Manager Name',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.deepOrange),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (String? newName) {
                      if (newName != null && newName.trim().isNotEmpty) {
                        model.name = newName;
                        updateNameManger(
                          context: context,
                          model: model,
                          controller: controller,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ),
                  onPressed: () async {
                    await deleteManger(
                      model: model,
                      controller: controller,
                      context: context,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.deepOrange,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  model.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.deepOrange,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Created: ${_formatDate(model.createdAt)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
