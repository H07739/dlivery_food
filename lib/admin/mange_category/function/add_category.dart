import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/main.dart';

import '../../../admin/add_food/function/uploadImage.dart';
import '../../../strings.dart';

Future<void> addCategory({
  required String name,
  required File imageFile,

  required BuildContext context
})async{
  try{
    String? image;
    if(supabase.auth.currentUser == null) throw 'user is not login ';

    image = await uploadImage(imageFile: imageFile, pathFolder: 'categorys', context: context);

    if(image == null) throw 'Failed to upload image';

    var result = await supabase.from(Table_Categorys).insert({
      "name": name,
      "image": image,
      "admin": supabase.auth.currentUser!.id
    });
    print('Food added successfully : $result');
  }
  catch(error){
    print('Failed to add food: $error');
    rethrow;
  }
}