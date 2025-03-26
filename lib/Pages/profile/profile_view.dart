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
import '../../widgets/MaterialButtonX.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  ValueNotifier<bool> selectedImage = ValueNotifier(false);
  String? image;

  ValueNotifier<File?> imageFile = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: ()async{
                  imageFile.value = await pickImage(imageSelect: selectedImage);
                },
                child: ClipOval(
                  child: ValueListenableBuilder<File?>(
                    valueListenable: imageFile,
                    builder: (BuildContext context, File? value, Widget? child) {
                      if(value != null){
                        return SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.file(
                            imageFile.value!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return ImageView(
                          height: 200,
                          width: 200,
                          url:
                          image ?? 'https://www.georgetown.edu/wp-content/uploads/2022/02/Jkramerheadshot-scaled-e1645036825432-1050x1050-c-default.jpg');
                    },

                  ),
                ),
              ),
              TextFieldEdit(
                hintText: 'Name',
                hintTextField: controllerName.text.isEmpty
                    ? 'Enter Name'
                    : controllerName.text,
                colorTextField: colorTextField,
                colorText: Colors.black,
                textEditingController: controllerName,
              ),
              const SizedBox(height: 10),
              TextFieldEdit(
                hintText: 'Email',
                hintTextField: controllerEmail.text.isEmpty
                    ? 'Enter Email'
                    : controllerEmail.text,
                colorTextField: colorTextField,
                colorText: Colors.black,
                textInputType: TextInputType.emailAddress,
                textEditingController: controllerEmail,
              ),
              const SizedBox(height: 10),
              TextFieldEdit(
                hintText: 'Address',
                hintTextField: controllerLocal.text.isEmpty
                    ? 'Enter Address'
                    : controllerLocal.text,
                colorTextField: colorTextField,
                colorText: Colors.black,
                textInputType: TextInputType.text,
                textEditingController: controllerLocal,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MaterialButtonX(
                      text: const Text(
                        'Updata',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: (ValueNotifier<bool> keyNotifier) async {
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

                          if (controllerLocal.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("The address is empty, please enter it."),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          keyNotifier.value = true;
                          await supabase.auth.updateUser(
                            UserAttributes(
                              data: {
                                "name": controllerName.text,
                                "address": controllerLocal.text,
                              },
                            ),
                          );
                          String? i;
                          if(imageFile.value != null){
                            // ignore: use_build_context_synchronously
                            i = await uploadImage(imageFile: imageFile.value!, pathFolder: 'user', context: context,url: image);
                          }

                          await supabase.auth.updateUser(
                            UserAttributes(
                              data: {
                                "name": controllerName.text,
                                "address": controllerLocal.text,
                                'image':i
                              },
                            ),
                          );

                          keyNotifier.value = false;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("User updated successfully")));
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error : $e")));
                          keyNotifier.value = false;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButtonX(
                    text: const Text(
                      'Sig out',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (ValueNotifier<bool> keyNotifier) async {
                      keyNotifier.value = true;
                      await supabase.auth.signOut();
                      OrderManager.clearOrders();
                      keyNotifier.value = false;
                      Get.offAll(() => AuthView());
                    },
                    color: Colors.deepOrangeAccent,
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    String? name = supabase.auth.currentUser!.userMetadata!['name'];
    String? email = supabase.auth.currentUser!.userMetadata!['email'];
    String? address = supabase.auth.currentUser!.userMetadata!['address'];
    image = supabase.auth.currentUser!.userMetadata!['image'];

    if (name != null) {
      setState(() {
        controllerName.text = name;
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
