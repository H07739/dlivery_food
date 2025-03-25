import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/home/model/category_model.dart';
import 'package:my_project/admin/add_food/function/pickImage.dart';
import 'package:my_project/admin/add_food/function/uploadImage.dart';
import 'package:my_project/admin/edit_food/function/update_food.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/showDialog.dart';
import '../function/delet_food.dart';
import '../model/EditFoodModel.dart';

class ItemFoodAdmin extends StatefulWidget {
  ItemFoodAdmin({super.key, required this.model,required this.onDelete,required this.index});
  EditFoodModel model;
  late CategoryModel categoryModel;
  int index;
  Function(int index) onDelete;
  @override
  State<ItemFoodAdmin> createState() => _ItemFoodAdminState();
}

class _ItemFoodAdminState extends State<ItemFoodAdmin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? imageFile;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.model.foodAdminModel.name;
    priceController.text = widget.model.foodAdminModel.price;
    descriptionController.text = widget.model.foodAdminModel.description;
    for (CategoryModel categor in widget.model.categoryModel) {
      if (categor.id == widget.model.foodAdminModel.idCategory) {
        widget.categoryModel = categor;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                url: widget.model.foodAdminModel.image,
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
                      widget.model.foodAdminModel.name = data;
                      setState(() {});
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
                      value: widget.categoryModel,
                      items: List.generate(widget.model.categoryModel.length,
                          (int index) {
                        return DropdownMenuItem(
                            value: widget.model.categoryModel[index],
                            child:
                                Text(widget.model.categoryModel[index].name));
                      }),
                      onChanged: (CategoryModel? value) {
                        if (value != null) {
                          widget.model.foodAdminModel.idCategory = value.id;
                          widget.categoryModel = value;
                          setState(() {});
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
                        widget.model.foodAdminModel.price = data;
                        setState(() {});
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
                        widget.model.foodAdminModel.description = data;
                        setState(() {});
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
                                model: widget.model.foodAdminModel,
                                context: context,
                                imageFile: imageFile);

                            if(url != null){
                              widget.model.foodAdminModel.image = url;
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
                        showDeleteDialog(context: context, onPressed: () async{
                          try {
                            keyNotifier.value = true;

                            await deleteFood(idFood:widget.model.foodAdminModel.id, context: context);

                            keyNotifier.value = false;
                            widget.onDelete(widget.index);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Deleted Food'))
                            );


                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$error'))
                            );
                          }

                        }, title: 'Delete Food', name: 'Food');
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
