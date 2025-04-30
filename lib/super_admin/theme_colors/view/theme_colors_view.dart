import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_colors_controller.dart';

class ThemeColorsView extends StatelessWidget {
  ThemeColorsView({super.key}) {
    Get.put(ThemeColorsController());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeColorsController>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Theme Colors',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
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
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildColorCard(
                          'Background Color',
                          'Main app background color',
                          controller.backgroundColor.value,
                          () => controller.showColorPicker(
                              controller.backgroundColor.value, controller.backgroundColor),
                        ),
                        const SizedBox(height: 16),
                        _buildColorCard(
                          'Text Bar Color',
                          'Color of text in bars',
                          controller.textBarColor.value,
                          () => controller.showColorPicker(
                              controller.textBarColor.value, controller.textBarColor),
                        ),
                        const SizedBox(height: 16),
                        _buildColorCard(
                          'Bottom Navigation Bar',
                          'Background color of bottom bar',
                          controller.bottomNavigationBarColor.value,
                          () => controller.showColorPicker(controller.bottomNavigationBarColor.value,
                              controller.bottomNavigationBarColor),
                        ),
                        const SizedBox(height: 16),
                        _buildColorCard(
                          'Selected Bottom Item',
                          'Color of selected bottom item',
                          controller.selectBottomItemColor.value,
                          () => controller.showColorPicker(controller.selectBottomItemColor.value,
                              controller.selectBottomItemColor),
                        ),
                        const SizedBox(height: 16),
                        _buildColorCard(
                          'Unselected Bottom Item',
                          'Color of unselected bottom item',
                          controller.unselectBottomItemColor.value,
                          () => controller.showColorPicker(controller.unselectBottomItemColor.value,
                              controller.unselectBottomItemColor),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: controller.saveColors,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade800,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save,
                                  size: 24,
                                  color: Colors.blue.shade800,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Save Colors',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
        ),
      ),
    );
  }

  Widget _buildColorCard(
      String title, String subtitle, Color color, VoidCallback onTap) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.color_lens,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 