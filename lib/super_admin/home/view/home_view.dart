import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme_colors/view/theme_colors_view.dart';
import '../widget/buildOptionCard.dart';
import '../../add_admin/view/add_admin_view.dart';
import '../../change_logo/view/change_logo_view.dart';
import '../function/showProfileDialog.dart';

class SuperAdminHomeView extends StatelessWidget {
  const SuperAdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.green.shade300,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Super Admin Panel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showProfileDialog(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OptionCard(
                        icon: Icons.person_add,
                        title: 'Add Admin',
                        subtitle: 'Add new admin to the system',
                        color: Colors.blue,
                        onTap: () {
                          Get.to(() => AddAdminView());
                        },
                      ),
                      const SizedBox(height: 16),
                      OptionCard(
                        icon: Icons.palette,
                        title: 'Change Theme',
                        subtitle: 'Modify application theme',
                        color: Colors.purple,
                        onTap: () {
                          Get.to(() => ThemeColorsView());
                        },
                      ),
                      const SizedBox(height: 16),
                      OptionCard(
                        icon: Icons.image,
                        title: 'Change Logo',
                        subtitle: 'Update application logo',
                        color: Colors.orange,
                        onTap: () {
                          Get.to(() => ChangeLogoView());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
