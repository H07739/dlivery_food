import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../strings.dart';
Future<List<FoodModel>> getFood({String? category, String? foodName,ValueNotifier<int?>? notifications}) async {
  try {
    final user = supabase.auth.currentUser;

    final selectColumns = user != null
        ? '*, $Table_Favorites(id_user)&$Table_Favorites.id_user=eq.${user.id}'
        : '*';

    var query = supabase
        .from(Table_Food)
        .select(selectColumns);
    if(user != null && notifications != null){
      List<Map<String,dynamic>> data = await supabase.from(Table_Notification)
          .select('*')
          .filter('id_receive', 'eq', user.id)
          .filter('read', 'eq', false);

      notifications.value = data.length;

    }





    if (category != null) {
      query = query.filter('categorys', 'eq', category);
    }

    if (foodName != null && foodName.isNotEmpty) {
      query = query.filter('name', 'ilike', '%$foodName%');
    }

    final response = await query;



    return List<FoodModel>.from(
      response.map((json) {
        List<dynamic>? f = json['Favorites'];
        bool isFav = false;
        if(f != null){
          for(Map<String,dynamic> u in f){
            if(u['id_user'] == user!.id){
              isFav = true;
              break;
            }
          }
        }
        return FoodModel.fromJson(json)..is_favorite = isFav;
      }),
    );
  } catch (er) {
    print('Error in getFood : $er');
    rethrow;
  }
}



