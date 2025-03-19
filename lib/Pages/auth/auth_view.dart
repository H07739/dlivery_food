
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../color.dart';
import 'login/loginView.dart';
import 'signup/signup_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              const SizedBox(
                height: 40,
              ),
              const Icon(
                Icons.lock,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome To Delivery App ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'You can login or register Now',
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    onPressed: ()=>Get.to(()=>Loginview()),
                    color: primaryColor,
                    child: const Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                        onPressed: ()=>Get.to(()=>SignupView()),
                    child: const Text(
                      'SignUp Now',
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
