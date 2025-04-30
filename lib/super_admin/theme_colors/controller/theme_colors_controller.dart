import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../main.dart';
import '../../../strings.dart';

class ThemeColorsController extends GetxController {
  final backgroundColor = Rx<Color>(Colors.blue.shade800);
  final textBarColor = Rx<Color>(Colors.white);
  final bottomNavigationBarColor = Rx<Color>(Colors.white);
  final selectBottomItemColor = Rx<Color>(Colors.blue.shade800);
  final unselectBottomItemColor = Rx<Color>(Colors.grey);

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadColors();
  }

  Future<void> loadColors() async {
    try {
      isLoading.value = true;

      final response = await supabase
          .from(Table_Seteing)
          .select()
          .eq('id', 1)
          .maybeSingle();

      if (response == null) {
        print('No settings found');
        return;
      }

      backgroundColor.value = Color(int.parse(response['backgroundColor'].toString().replaceFirst('0x', ''), radix: 16));
      textBarColor.value = Color(int.parse(response['textBarColor'].toString().replaceFirst('0x', ''), radix: 16));
      bottomNavigationBarColor.value = Color(int.parse(response['bottomNavigtionBarColor'].toString().replaceFirst('0x', ''), radix: 16));
      selectBottomItemColor.value = Color(int.parse(response['selectBottomItemColor'].toString().replaceFirst('0x', ''), radix: 16));
      unselectBottomItemColor.value = Color(int.parse('0xff' + response['unselectBottomItemColor'].toString().replaceAll('0x', '').padLeft(6, '0')));

    } catch (e) {
      print('Error loading colors: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> saveColors() async {
    try {
      isLoading.value = true;
      await supabase.from(Table_Seteing).update({
        'backgroundColor': backgroundColor.value.value.toRadixString(16),
        'textBarColor': textBarColor.value.value.toRadixString(16),
        'bottomNavigtionBarColor': bottomNavigationBarColor.value.value.toRadixString(16),
        'selectBottomItemColor': selectBottomItemColor.value.value.toRadixString(16),
        'unselectBottomItemColor': unselectBottomItemColor.value.value.toRadixString(16),
      }).eq('id', 1);

      Get.snackbar(
        'Success',
        'Theme colors saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save colors: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showColorPicker(Color currentColor, Rx<Color> colorVariable) {
    Get.dialog(
      AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => colorVariable.value = color,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
            displayThumbColor: true,
            showLabel: true,
            paletteType: PaletteType.hsvWithHue,
            pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
} 