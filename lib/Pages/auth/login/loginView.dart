import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/auth/login/role.dart';
import 'package:my_project/Pages/home/view/home_view.dart';
import 'package:my_project/admin/home/view/admin_view.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../admin/MealPlan/view/manger_orders_view.dart';
import '../../../admin/setting/model/manger_model.dart';
import '../../../super_admin/home/view/home_view.dart';
import '../../../widgets/MaterialButtonX.dart';
import '../../profile/text_field.dart';
import 'package:my_project/main.dart';

class Loginview extends StatelessWidget {
  Loginview({super.key});
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  List<String> items = ['client', 'admin', 'maingear', 'super Admin'];

  ValueNotifier<String> selectedItem = ValueNotifier('client');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Please enter your credentials to login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topRight,
                    child: ValueListenableBuilder<String>(
                      valueListenable: selectedItem,
                      builder:
                          (BuildContext context, String value, Widget? child) {
                        return DropdownButton<String>(
                          value: selectedItem.value,
                          hint: Text('اختر عنصرًا'),
                          items: items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              selectedItem.value = newValue;
                            }
                          },
                        );
                      },
                    ),
                  ),
                  TextFieldEdit(
                    hintTextField: 'Enter your Email',
                    textEditingController: controllerEmail,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFieldEdit(
                    hintTextField: 'Enter your Password',
                    textEditingController: controllerPassword,
                    hintText: 'Password',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: MaterialButtonX(
                      onPressed: (ValueNotifier<bool> keyNotifier) async {
                        try {
                          if (controllerEmail.text.isEmpty ||
                              controllerPassword.text.isEmpty) return;
                          keyNotifier.value = true;
                          await supabase.auth.signInWithPassword(
                            email: controllerEmail.text,
                            password: controllerPassword.text,
                          );
                          keyNotifier.value = false;

                          Map<String, dynamic> d = await check();
                          String? role = supabase.auth.currentUser
                              ?.userMetadata?['role'] as String?;
                          if (role != null) {



                            if (role == Role.superAdmin) {
                              if(_checkPermission(role: 'super Admin', context: context)) {
                                Get.offAll(() => SuperAdminHomeView());
                              }


                            }
                            else if (role == Role.admin) {

                              if(_checkPermission(role: 'admin', context: context)) {
                                Get.offAll(() => AdminView());
                              }




                            }


                            else if (role == Role.manger) {
                              if(_checkPermission(role: 'maingear', context: context)) {
                                Get.offAll(() => MangerOrdersView(model: MangerModel.fromJson(d['model'][0])));
                              }

                            }
                            else {
                              if(_checkPermission(role: 'client', context: context)) {
                                Get.offAll(() => HomeView());
                              }

                            }
                          } else {
                            if(_checkPermission(role: 'client', context: context)) {
                              Get.offAll(() => HomeView());
                            }
                          }
                        } on AuthException catch (e) {
                          keyNotifier.value = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        } catch (e) {
                          keyNotifier.value = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error : $e"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      },
                      text: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool _checkPermission({required String role, required BuildContext context}) {
    if (selectedItem.value == role) {
      return true;
    } else {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: You do not have permission"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      });

      // تأخير تسجيل الخروج لضمان عرض SnackBar أولًا
      Future.delayed(Duration(seconds: 2), () {
        supabase.auth.signOut();
      });

      return false;
    }
  }

}
