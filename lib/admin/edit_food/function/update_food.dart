import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

import '../../add_food/function/uploadImage.dart';
import '../model/food_admin_model.dart';

Future<String?> updateFood({required FoodAdminModel model,File? imageFile,required BuildContext context})async{
  try {
    if (imageFile!= null) {
      String? imageUrl = await uploadImage(imageFile: imageFile, pathFolder: 'food', context: context,url: model.image);
      if(imageUrl != null){
        model.image = imageUrl;

      }
      else{
        throw 'Image does upload';
      }

    }
    await await supabase.from(Table_Food).update(model.toJson()).eq('id',model.id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Food Success')));
    return model.image;

  } on Exception catch (e) {
    print('Error updating food: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Filde Update Food Place Try Again')));
    rethrow;
  }
}