import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/Pages/add_food/function/uploadImage.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';

Future<void> addFood({
  required String name,
  required File imageFile,
  required String description,
  required String price,
  required String categorys,
  required BuildContext context
})async{
  try{
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
    });
    print('Food added successfully : $result');
  }
  catch(error){
    print('Failed to add food: $error');
    rethrow;
  }
}