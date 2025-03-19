import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../../home/model/food_detail_model.dart';

Future<void> addDetail(
    {
      required List<FoodDetailModel> details,
      required int count,
      required int idRequests
    }) async {
  try {
    Map<String,dynamic> data ={
      'id_request':idRequests,

    };
    for( FoodDetailModel d in details){
      data[d.name]=count;
    }
    await supabase.from(Table_Food_Detail).insert(data);
  } catch (error) {
    print('Error AddDetailDataBase : $error');
    rethrow;
  }
}
