import 'package:my_project/Pages/home/model/food_detail_model.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

Future<List<FoodDetailModelX>> getFoodDetail() async {
  try {
    List<Map<String,dynamic>> foodResult = await supabase.from(Table_Detail).select('*');
    print('foodResult is ${foodResult}');
    return foodResult.map((food) => FoodDetailModelX.fromMap(food)).toList();
  } catch (e) {
    print('error getting food detail : $e');
    rethrow;
  }
}
