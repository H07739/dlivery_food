import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/auth/auth_view.dart';
import 'package:my_project/Pages/profile/text_field.dart';
import 'package:my_project/admin/add_food/function/pickImage.dart';
import 'package:my_project/admin/add_food/function/uploadImage.dart';
import 'package:my_project/main.dart';
import 'package:my_project/widgets/image_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../color.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  ValueNotifier<bool> selectedImage = ValueNotifier(false);
  String? image;

  ValueNotifier<File?> imageFile = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textBarColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: supabase.auth.currentUser != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                          GestureDetector(
                            onTap: () async {
                              imageFile.value = await pickImage(imageSelect: selectedImage);
                            },
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: ValueListenableBuilder<File?>(
                                    valueListenable: imageFile,
                                    builder: (BuildContext context, File? value, Widget? child) {
                                      if (value != null) {
                                        return SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Image.file(
                                            imageFile.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }
                                      return ImageView(
                                        height: 150,
                                        width: 150,
                                        url: image ??
                                            'https://www.georgetown.edu/wp-content/uploads/2022/02/Jkramerheadshot-scaled-e1645036825432-1050x1050-c-default.jpg',
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: secondary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFieldEdit(
                            hintText: 'First Name',
                            hintTextField: controllerName.text.isEmpty
                                ? 'Enter First Name'
                                : controllerName.text,
                            colorTextField: Colors.grey.shade100,
                            colorText: Colors.black87,
                            textEditingController: controllerName,
                          ),
                          TextFieldEdit(
                            hintText: 'Last Name',
                            hintTextField: controllerLastName.text.isEmpty
                                ? 'Enter Last Name'
                                : controllerLastName.text,
                            colorTextField: Colors.grey.shade100,
                            colorText: Colors.black87,
                            textEditingController: controllerLastName,
                          ),
                          const SizedBox(height: 16),
                          TextFieldEdit(
                            hintText: 'Email',
                            hintTextField: controllerEmail.text.isEmpty
                                ? 'Enter Email'
                                : controllerEmail.text,
                            colorTextField: Colors.grey.shade100,
                            colorText: Colors.black87,
                            textInputType: TextInputType.emailAddress,
                            textEditingController: controllerEmail,
                          ),
                          const SizedBox(height: 16),
                          TextFieldEdit(
                            hintText: 'Address',
                            hintTextField: controllerLocal.text.isEmpty
                                ? 'Enter Address'
                                : controllerLocal.text,
                            colorTextField: Colors.grey.shade100,
                            colorText: Colors.black87,
                            textInputType: TextInputType.text,
                            textEditingController: controllerLocal,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (controllerName.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Name, please enter."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      if (controllerLastName.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("LastName, please enter."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      if (controllerLocal.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("The address is empty, please enter it."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      String? i;
                                      if (imageFile.value != null) {
                                        i = await uploadImage(
                                          imageFile: imageFile.value!,
                                          pathFolder: 'user',
                                          context: context,
                                          url: image,
                                        );
                                      }

                                      await supabase.auth.updateUser(
                                        UserAttributes(
                                          data: {
                                            "name": controllerName.text,
                                            "address": controllerLocal.text,
                                            'image': i,
                                            "name_last":controllerLastName.text
                                          },
                                        ),
                                      );

                                      setState(() {});
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("User updated successfully"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      print(e);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Error : $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: secondary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: const Text(
                                    'Update Profile',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await supabase.auth.signOut();
                                    OrderManager.clearOrders();
                                    Get.offAll(() => const AuthView());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade300,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: const Text(
                                    'Sign Out',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You need to log in first',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const AuthView());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondary,
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
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (supabase.auth.currentUser == null) return;
    String? name = supabase.auth.currentUser!.userMetadata!['name'];
    String? nameLast = supabase.auth.currentUser!.userMetadata!['name_last'];
    String? email = supabase.auth.currentUser!.userMetadata!['email'];
    String? address = supabase.auth.currentUser!.userMetadata!['address'];
    image = supabase.auth.currentUser!.userMetadata!['image'];

    if (name != null) {
      setState(() {
        controllerName.text = name;
      });
    }
    if (nameLast != null) {
      setState(() {
        controllerLastName.text = nameLast;
      });
    }
    if (email != null) {
      setState(() {
        controllerEmail.text = email;
      });
    }
    if (address != null) {
      setState(() {
        controllerLocal.text = address;
      });
    }
    if (image != null) {
      setState(() {});
    }
  }
}
