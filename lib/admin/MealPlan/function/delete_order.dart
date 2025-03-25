import 'package:flutter/material.dart';

import '../../../Pages/meal_plan/model/meal_plan_model.dart';
import '../../../main.dart';
import '../../../strings.dart';

Future<void> deleteOrder({required MealPlanModel model,required BuildContext context})async{
  try {
    await supabase
        .from(Table_Requests)
        .delete()
        .eq('id', model.id);
    print('Delete state scuessful');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Order Success')));
  } catch (e) {
    print('Error delete order : $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete Order Failure')));
    rethrow;
  }
}