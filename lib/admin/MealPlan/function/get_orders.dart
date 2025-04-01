import '../../../Pages/home/model/food_detail_model.dart';
import '../../../Pages/home/model/food_model.dart';
import '../../../Pages/meal_plan/model/meal_plan_model.dart';
import '../../../Pages/shopping_cart/model/FoodOrderModel.dart';
import '../../../main.dart';
import '../../../strings.dart';

Future<List<MealPlanModel>> getOrders()async{
  try{

    List<MealPlanModel> orders =[];

    List<Map<String,dynamic>> requests = await supabase.from(Table_Requests).select().eq('admin', supabase.auth.currentUser!.id).order('id', ascending: false);

    for(var request in requests){

      List<Map<String,dynamic>> foods =await supabase.rpc('get_food_by_id_and_check_favorites',params:{'p_food_id':request['food_id']});
      FoodModel food = FoodModel.fromJson(foods[0]);
      FoodOrderModel foodOrderModel = FoodOrderModel(foodModel: food);
      List<Map<String,dynamic>> details = await supabase.from(Table_Food_Detail).select().eq('id_request',request['id']);

      for(int i = 0; i < details.length; i++){
        List<Map<String,dynamic>> f = await supabase.from(Table_Detail).select('*').eq('id', details[i]['id_suplem']);
        for(Map<String,dynamic> s in f ){
          foodOrderModel.toggleExtra(FoodDetailModelX.fromMap(s)..check=true);
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