
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/auth/login/loginView.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../../widgets/MaterialButtonX.dart';
import '../../home/view/home_view.dart';


class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerFirsName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(

              color: Colors.white,

            ),
            child: Column(
              children: [
                // Header with background
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(

                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFE86F4D),
                        Color(0xFFB6D97B),
                        Color(0xFF5AC8FA),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Create an\naccount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const SizedBox(height: 16),
                // Name Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerFirsName,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: controllerLastName,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Email Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: controllerEmail,
                    decoration: InputDecoration(

                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Password Field
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: controllerPassword,
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon:IconButton(onPressed: (){
                        setState(() {
                          showPassword=!showPassword;
                        });
                      }, icon: showPassword?Icon(Icons.visibility_off):Icon(Icons.visibility_rounded)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Create Account Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: MaterialButtonX(
                      onPressed: (ValueNotifier<bool> keyNotifier) async {
                        try {
                          if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty || controllerFirsName.text.isEmpty || controllerLastName.text.isEmpty) return;
                          keyNotifier.value = true;
                          AuthResponse a = await supabase.auth.signUp(
                            email: controllerEmail.text,
                            password: controllerPassword.text,
                          );
                          keyNotifier.value = false;
                          await supabase.auth.updateUser(
                            UserAttributes(
                              data: {
                                "name":controllerFirsName.text,
                                'name_last':controllerLastName.text
                              },
                            ),
                          );
                          
                          await supabase.auth.signOut();

                          Get.offAll(Loginview());
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
                        'Create account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Terms and Privacy
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text.rich(
                    TextSpan(
                      text: "Signing up for a Webflow account means you agree to the ",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Terms of Service.",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                // Login Link
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(color: Colors.grey[800], fontSize: 15),
                        children: [
                          TextSpan(

                            text: "Log in here",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
