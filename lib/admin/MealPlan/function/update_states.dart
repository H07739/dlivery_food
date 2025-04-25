import 'package:my_project/admin/edit_food/function/send_notification.dart';
import 'package:my_project/main.dart';

import '../../../Pages/meal_plan/model/meal_plan_model.dart';
import '../../../strings.dart';

Future<void> updateState({required MealPlanModel model}) async {
  try {
    await supabase
        .from(Table_Requests)
        .update(model.toJson())
        .eq('id', model.id);
    await sendNotification(idUser: model.idUser, title: 'Question case', body: 'The order is ${model.status}');
    print('Updated state scuessful');
  } catch (e) {
    print('Error updating state : $e');
    rethrow;
  }
}
