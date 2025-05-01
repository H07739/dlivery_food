import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/home/model/category_model.dart';
import 'package:my_project/admin/MealPlan/view/my_detail_view.dart';
import 'package:my_project/admin/add_food/function/pickImage.dart';
import 'package:my_project/admin/edit_food/controller/food_controller.dart';
import 'package:my_project/admin/edit_food/function/update_food.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../../widgets/image_view.dart';
import '../../MealPlan/view/add_detail_view.dart';
import '../function/delet_food.dart';
import '../model/EditFoodModel.dart';
import '../model/food_admin_model.dart';

class ItemFoodAdmin extends StatelessWidget {
  ItemFoodAdmin({super.key, required this.model, required this.controller});
  EditFoodModel model;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rivalController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? imageFile;
  FoodController controller;

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }



  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartTime
          ? model.foodAdminModel.startDiscount ?? DateTime.now()
          : model.foodAdminModel.endDiscount ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: isStartTime
            ? model.foodAdminModel.startDiscount != null
                ? TimeOfDay.fromDateTime(model.foodAdminModel.startDiscount!)
                : TimeOfDay.now()
            : model.foodAdminModel.endDiscount != null
                ? TimeOfDay.fromDateTime(model.foodAdminModel.endDiscount!)
                : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (isStartTime) {
          model.foodAdminModel.startDiscount = selectedDateTime;
          startTimeController.text = _formatDateTime(selectedDateTime);
        } else {
          model.foodAdminModel.endDiscount = selectedDateTime;
          endTimeController.text = _formatDateTime(selectedDateTime);
        }


        controller.updateFood(model.foodAdminModel.id,model);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = model.foodAdminModel.name;
    priceController.text = model.foodAdminModel.price;
    descriptionController.text = model.foodAdminModel.description;
    if(model.foodAdminModel.rival != null){
      rivalController.text = model.foodAdminModel.rival.toString();
    }
    startTimeController.text = _formatDateTime(model.foodAdminModel.startDiscount);
    endTimeController.text = _formatDateTime(model.foodAdminModel.endDiscount);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: imageSelect,
            builder: (BuildContext context, bool value, Widget? child) {
              return GestureDetector(
                onTap: () async {
                  imageFile = await pickImage(imageSelect: imageSelect);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: value
                      ? Image.file(
                          imageFile!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : ImageView(
                          url: model.foodAdminModel.image,
                          width: double.infinity,
                          height: 200,
                        ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Food Name',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepOrange),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (String? data) {
                    if (data != null) {
                      model.foodAdminModel.name = data;
                      controller.updateFood(model.foodAdminModel.id, model);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      DropdownButton<CategoryModel>(
                        value: model.category ?? model.categoryModel[0],
                        items: List.generate(model.categoryModel.length, (int index) {
                          return DropdownMenuItem(
                            value: model.categoryModel[index],
                            child: Text(
                              model.categoryModel[index].name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }),
                        onChanged: (CategoryModel? value) {
                          if (value != null) {
                            model.foodAdminModel.idCategory = value.id;
                            model.category = value;
                            controller.updateFood(model.foodAdminModel.id, model);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          prefixText: 'D',
                          prefixStyle: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.deepOrange),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onChanged: (String? data) {
                          if (data != null) {
                            model.foodAdminModel.price = data;
                            controller.updateFood(model.foodAdminModel.id, model);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: rivalController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Discount',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          suffixText: '%',
                          suffixStyle: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onChanged: (String? data) {
                          if (data != null) {
                            final value = int.tryParse(data);
                            if (value != null) {
                              model.foodAdminModel.rival = value;
                              controller.updateFood(model.foodAdminModel.id, model);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDateTime(context, true),
                        child: TextField(
                          controller: startTimeController,
                          enabled: false,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Start Discount Time',
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            hintText: 'Tap to select date and time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            suffixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDateTime(context, false),
                        child: TextField(
                          controller: endTimeController,
                          enabled: false,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            labelText: 'End Discount Time',
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                            hintText: 'Tap to select date and time',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            suffixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepOrange),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (String? data) {
                    if (data != null) {
                      model.foodAdminModel.description = data;
                      controller.updateFood(model.foodAdminModel.id, model);
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(
                          () => AddDetailView(idFood: model.foodAdminModel.id),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Add Detail',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(
                          () => MyDetailView(idFood: model.foodAdminModel.id),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'My Detail',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (nameController.text.isEmpty) {
                              throw 'Please input name';
                            }
                            if (descriptionController.text.isEmpty) {
                              throw 'Please input description';
                            }
                            if (priceController.text.isEmpty) {
                              throw 'Please input price';
                            }

                            String? url = await updateFood(
                              model: model.foodAdminModel,
                              context: context,
                              imageFile: imageFile,
                            );

                            if (url != null) {
                              model.foodAdminModel.image = url;
                              imageFile = null;
                              imageSelect.value = false;
                            }
                          } catch (error) {
                            print(error);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Update Food',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await confirmDeleteFood(
                              idFood: model.foodAdminModel.id,
                              context: context,
                              controller: controller,
                            );
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Delete Food',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            model.foodAdminModel.startDiscount = null;
                            model.foodAdminModel.endDiscount = null;
                            startTimeController.text = '';
                            endTimeController.text = '';
                            controller.updateFood(model.foodAdminModel.id, model);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
                          'Delete Discount',
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
    );
  }
}
