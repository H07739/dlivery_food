import 'package:my_project/main.dart';

Future<void> AddFoodCart(
    {required int foodId,
      required int count,
      required int countCutshup,
      required int countMayounez,
      required int countHarissa,
      required int countOuef
    }) async {
  try {
    await supabase.from('item_food').insert({
      'food_id': foodId,
      'food_count': count,
      'id_user': supabase.auth.currentUser!.id,
    });
  } catch (error) {
    print('Error AddFoodCart : $error');
    rethrow;
  }
}
