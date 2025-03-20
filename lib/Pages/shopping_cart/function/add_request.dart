import 'package:my_project/Pages/shopping_cart/function/add_detail.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/FoodOrderModel.dart';

Future<void> addRequest(
    {required FoodOrderModel order
    }) async {
  try {
    List<Map<String, dynamic>> d = await supabase.from(Table_Requests).insert({
      'food_id': order.foodModel.id,
      'food_count': order.count.value,
      'id_user': supabase.auth.currentUser!.id,
      'price':order.totalPrice.value.toString(),
      'admin':order.foodModel.seller
    }).select();

    await addDetail(details: order.selectedExtras.value, count: order.count.value, idRequests: d[0]['id']);
    print('Request added successfully! id: ${d[0]['id']}');
  } catch (error) {
    print('Error AddFoodCart : $error');
    rethrow;
  }
}
