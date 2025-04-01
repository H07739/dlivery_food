import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/main.dart';

Future<List<FoodModel>> getFood({String? category,String? foodName}) async {
  try {
    final response = await supabase
        .rpc('get_food_and_check_favorites',params: {'category_id':category,'food_name_filter':foodName});

    return List<FoodModel>.from(response.map((json) => FoodModel.fromJson(json)));
  } catch (er) {
    print('Error in getFood : $er');
    rethrow;
  }
}
