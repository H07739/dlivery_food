import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../../home/model/food_detail_model.dart';

Future<void> addDetail(
    {
      required List<FoodDetailModelX> details,
      required int idRequests
    }) async {
  try {
    Map<String,dynamic> data ={
      'id_request':idRequests,

    };
    for( FoodDetailModelX d in details){
      data['id_suplem']= d.id;
      await supabase.from(Table_Food_Detail).insert(data);
    }


  } catch (error) {
    print('Error AddDetailDataBase : $error');
    rethrow;
  }
}
