import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/admin/setting/function/add_manger.dart';
import 'package:my_project/admin/setting/widget/item_manger.dart';
import 'package:my_project/admin/setting/model/manger_model.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../function/get_mangers.dart';

class MangerView extends StatelessWidget {
  MangerView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  MangerController controller = Get.put(MangerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Manager',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Add New Manager',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
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
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
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
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final name = _nameController.text.trim();
                      if (email.isNotEmpty && name.isNotEmpty) {
                        await addManger(
                          email: email,
                          name: name,
                          context: context,
                          controller: controller,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Add Manager',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manager List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilderX<List<MangerModel>>(
                    future: () => getMangers(context: context),
                    loadingView: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                    errorView: (String error, ValueNotifier<int> keyNotifier) => Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                    doneView: (List<MangerModel> data, ValueNotifier<int> keyNotifier) {
                      controller.setManagers(data);
                      return Obx(
                        () => SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView.builder(
                            itemCount: controller.managers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemManger(
                                model: controller.managers[index],
                                controller: controller,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
