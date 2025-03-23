import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/Pages/category/function/add_category.dart';
import 'package:my_project/color.dart';
import 'package:get/get.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

import '../../../admin/add_food/function/pickImage.dart';
class AddCategory extends StatelessWidget {
  AddCategory({super.key});
  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? _image;
  TextEditingController nameCategoryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios,color: Colors.grey,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity,),
              SizedBox(height: 10,),
              Text('Category Name',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameCategoryController,

                  )),
              SizedBox(height: 10,),
              Text('Category Image',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              ValueListenableBuilder<bool>(
                valueListenable: imageSelect,
                builder: (BuildContext context, bool value, Widget? child) {
                  if (value) {
                    return Column(
                      children: [
                        Image.file(
                          height:200,
                          width: MediaQuery.of(context).size.width / 2,
                          _image!,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(onPressed: (){
                          _image = null;
                          imageSelect.value=false;
                        }, child: Text('change image'))

                      ],
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.2))
                          ]),
                      child: IconButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          _image = await pickImage(imageSelect: imageSelect);
                        },
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButtonX(
                        text: Text('Add Category'),
                        onPressed: (ValueNotifier<bool> keyNotifier) async {
                          keyNotifier.value = true;
                          try {
                            if (_image == null) {
                              throw 'place selected image';
                            }
                            if (nameCategoryController.text.isEmpty) {
                              throw 'place input name';
                            }

                            await addCategory(name: nameCategoryController.text, imageFile: _image!, context: context);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Add Category successfully')));
                            nameCategoryController.clear();
                            imageSelect.value=false;
                            _image = null;
                          } catch (error) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('$error')));
                          }
                          keyNotifier.value = false;
                        },
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
