import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Pages/shopping_cart/function/add_detail.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/FoodOrderModel.dart';

Future<void> addRequest(
    {required FoodOrderModel order,
      required BuildContext context,
    }) async {
  try {
    String? address = supabase.auth.currentUser!.userMetadata!['address'];
    if (address == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid address in the profile')));
      throw Exception('Please enter a valid address in the profile');
    }
    List<Map<String, dynamic>> d = await supabase.from(Table_Requests).insert({
      'food_id': order.foodModel.id,
      'food_count': order.count.value,
      'id_user': supabase.auth.currentUser!.id,
      'price':order.totalPrice.value.toString(),
      'admin':order.foodModel.seller,
      'address':address
    }).select();

    await addDetail(details: order.selectedExtras.value, count: order.count.value, idRequests: d[0]['id']);
    print('Request added successfully! id: ${d[0]['id']}');
  } catch (error) {
    print('Error AddFoodCart : $error');
    rethrow;
  }
}
