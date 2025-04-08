import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/category_model.dart';
import 'package:my_project/admin/add_food/function/pickImage.dart';
import 'package:my_project/admin/edit_food/controller/food_controller.dart';
import 'package:my_project/admin/edit_food/function/update_food.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../../widgets/image_view.dart';
import '../function/delet_food.dart';
import '../model/EditFoodModel.dart';


class ItemFoodAdmin extends StatelessWidget {
  ItemFoodAdmin({super.key,required this.model,required this.controller});
  EditFoodModel model;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? imageFile;
  FoodController controller;

  @override
  Widget build(BuildContext context) {
        nameController.text = model.foodAdminModel.name;
    priceController.text = model.foodAdminModel.price;
    descriptionController.text = model.foodAdminModel.description;

    return Container(

      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
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
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                        child: value
                            ? Image.file(
                          imageFile!,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                            : ImageView(
                          url:model.foodAdminModel.image,
                          width: double.infinity,
                          height: 150,
                        ),
                      ),
                    );
                  },
                ),
                TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(helperText: 'Name food'),
                  onChanged: (String? data) {
                    if (data != null) {
                      model.foodAdminModel.name = data;
                      controller.updateFood(model.foodAdminModel.id, model);

                    }
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    DropdownButton<CategoryModel>(
                      value:model.category ?? model.categoryModel[0],
                      items: List.generate(model.categoryModel.length,
                              (int index) {
                            return DropdownMenuItem(
                                value:model.categoryModel[index],
                                child: Text(model.categoryModel[index].name));
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
                const SizedBox(
                  height: 4,
                ),
                TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(helperText: 'Price food'),
                    onChanged: (String? data) {
                      if (data != null) {
                        model.foodAdminModel.price = data;
                        controller.updateFood(model.foodAdminModel.id, model);
                      }
                    }),
                TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      helperText: 'Description',
                    ),
                    onChanged: (String? data) {
                      if (data != null) {
                        model.foodAdminModel.description = data;
                        controller.updateFood(model.foodAdminModel.id, model);
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButtonX(
                        text: Text(
                          'Update Food',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: (ValueNotifier<bool> keyNotifier) async {

                          try {

                            if (nameController.text.isEmpty) {
                              throw 'place input name';
                            }
                            if (descriptionController.text.isEmpty) {
                              throw 'place input description';
                            }
                            if (priceController.text.isEmpty) {
                              throw 'place input price';
                            }

                            keyNotifier.value = true;
                            String? url = await updateFood(
                                model:model.foodAdminModel,
                                context: context,
                                imageFile: imageFile);

                            if(url != null){
                              model.foodAdminModel.image = url;
                              imageFile=null;
                              imageSelect.value=false;
                            }

                            keyNotifier.value = false;
                          } catch (error) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('$error')));
                            keyNotifier.value = false;
                          }
                        }

                    ),
                    MaterialButtonX(
                      color: Colors.red,
                      text: Text(
                        'Deleted Food',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (ValueNotifier<bool> keyNotifier) async{
                        try {
                          keyNotifier.value = true;

                          await confirmDeleteFood(idFood:model.foodAdminModel.id, context: context, controller: controller);

                          keyNotifier.value = false;
                         


                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$error'))
                          );
                        }
                      },
                    )
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
