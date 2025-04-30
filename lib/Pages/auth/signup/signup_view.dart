import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/home/view/home_view.dart';
import 'package:my_project/Pages/profile/profile_view.dart';
import 'package:my_project/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../widgets/MaterialButtonX.dart';
import '../../profile/text_field.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Icons.person_add,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Create Account',
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
                      'Please fill in your details to create an account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                          if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) return;
                          keyNotifier.value = true;
                          AuthResponse a = await supabase.auth.signUp(
                            email: controllerEmail.text,
                            password: controllerPassword.text,
                          );
                          keyNotifier.value = false;
                          Get.off(() => const HomeView());
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
                        'Sign Up',
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
}

