import 'package:my_project/Pages/home/model/food_model.dart';
import '../../../main.dart';
import '../../../strings.dart';


Future<List<FoodModel>> getFavoriteFoods() async {
  try {
    final user = supabase.auth.currentUser;

    if (user == null) return [];

    final response = await supabase
        .from(Table_Favorites)
        .select('food_id, $Table_Food(*)')
        .eq('id_user', user.id);

    return List<FoodModel>.from(
      response.map((json) {
        final foodData = json[Table_Food];
        return FoodModel.fromJson(foodData)..is_favorite = true;
      }),
    );
  } catch (er) {
    print('Error in getFavoriteFoods: $er');
    return [];
  }
}

