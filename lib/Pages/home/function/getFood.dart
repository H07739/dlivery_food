import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/main.dart';

Future<List<FoodModel>> getFood({required int index}) async {
  try {
    final response = await supabase
        .rpc('get_food_and_check_favorites');
    print(response);
    return List<FoodModel>.from(response.map((json) => FoodModel.fromJson(json)));
  } catch (er) {
    print('Error in getFood : $er');
    rethrow;
  }
}
