import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/add_food/function/pickImage.dart';
import 'package:my_project/admin/mange_category/function/delete_category.dart';
import 'package:my_project/admin/mange_category/function/update_category.dart';
import 'package:my_project/admin/mange_category/model/category_admin_model.dart';
import 'package:my_project/widgets/image_view.dart';

import '../../../widgets/MaterialButtonX.dart';
import '../../../widgets/showDialog.dart';

class ItemCategortAdmin extends StatefulWidget {
  ItemCategortAdmin(
      {super.key,
      required this.model,
      required this.categoryList,
      required this.index});
  CategoryAdminModel model;
  ValueNotifier<List<CategoryAdminModel>> categoryList;
  int index;

  @override
  State<ItemCategortAdmin> createState() => _ItemCategortAdminState();
}

class _ItemCategortAdminState extends State<ItemCategortAdmin> {
  TextEditingController nameController = TextEditingController();
  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? imageFile;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.model.name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () async {
                  imageFile = await pickImage(imageSelect: imageSelect);
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: imageSelect,
                  builder: (BuildContext context, bool value, Widget? child) {
                    if (imageFile != null) {
                      return Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      );
                    } else {
                      return ImageView(
                        url: widget.model.image,
                        width: 50,
                        height: 50,
                      );
                    }
                  },
                ),
              ),
              title: TextField(
                controller: nameController,
                onChanged: (String? value) {
                  if (value != null) {
                    widget.model.name = value;
                  }
                },
                decoration: InputDecoration(helperText: 'Name Categor'),
              ),
              subtitle: Text(" Time : ${widget.model.createdAt.toString()}"),
              trailing: IconButton(
                onPressed: () {
                  showDeleteDialog(
                      context: context, onPressed: () async{
                    try {
                      await deleteCategory(model: widget.model, context: context);

                      widget.categoryList.value = List.from(widget.categoryList.value)..remove(widget.model);

                      print('✅  Category deleted successfully  ');
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('❌   Error while deleting the category: $e');
                    }
                  }, title: 'Delete Category', name: 'Category');
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButtonX(
                  text: Text(
                    'Update Category',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: (ValueNotifier<bool> keyNotifier) async {
                    try {
                      await updateCategory(
                          model: widget.model,
                          context: context,
                          file: imageFile);
                    } catch (er) {
                      print('error in update category : $er');
                    }
                  },
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
