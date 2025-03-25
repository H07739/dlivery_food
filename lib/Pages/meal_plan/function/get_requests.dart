
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/shopping_cart/model/FoodOrderModel.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../../home/model/food_detail_model.dart';
import '../model/meal_plan_model.dart';

Future<List<MealPlanModel>> getRequests({String? coulum})async{
  try{

    List<MealPlanModel> orders =[];

    List<Map<String,dynamic>> requests = await supabase.from(Table_Requests).select().eq(coulum ?? 'id_user', supabase.auth.currentUser!.id).order('id', ascending: false);

    for(var request in requests){

      List<Map<String,dynamic>> foods =await supabase.rpc('get_food_by_id_and_check_favorites',params:{'p_food_id':request['food_id']});
      FoodModel food = FoodModel.fromJson(foods[0]);
      FoodOrderModel foodOrderModel = FoodOrderModel(foodModel: food);
      List<Map<String,dynamic>> details = await supabase.from(Table_Food_Detail).select().eq('id_request',request['id']);
      for(int i = 0; i < details.length; i++){
        FoodDetailModel foodDetailModel;
        if(details[i][foodOrderModel.details.value[i].name] != null){
          foodDetailModel = foodOrderModel.details.value[i];
          foodDetailModel.check =true;
          foodOrderModel.toggleExtra(foodDetailModel);

        }
      }


      orders.add(MealPlanModel(json: request, orderModel: foodOrderModel));

    }

    return orders;

  }
  catch(e){
    print(e);
    rethrow;
  }
}
