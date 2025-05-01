import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/add_food/function/uploadImage.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../../setting/controller/setting_controller.dart';

Future<void> addFood({
  required String name,
  required File imageFile,
  required String description,
  required String price,
  required String categorys,
  required int idcategory,
  required BuildContext context
})async{
  try{
    final controller = Get.find<SettingController>();

    String? image;
    if(supabase.auth.currentUser == null) throw 'user is not login ';

    image = await uploadImage(imageFile: imageFile, pathFolder: 'food', context: context);

    if(image == null) throw 'Failed to upload image';

    var result = await supabase.from(Table_Food).insert({
      "name": name, // ok
      "image": image, // ok
      "description": description, // ok
      "price": price, // ok
      "categorys": categorys, //ok
      "admin":supabase.auth.currentUser!.id, // ok
      "id_category":idcategory,
      'restaurant':controller.admin.value!.restaurantAdmin
    });
    print('Food added successfully : $result');
  }
  catch(error){
    print('Failed to add food: $error');
    rethrow;
  }
}