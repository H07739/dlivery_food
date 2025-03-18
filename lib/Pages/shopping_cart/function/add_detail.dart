import 'package:my_project/main.dart';

import '../../../strings.dart';

Future<void> AddDetailDataBase(
    {required int countCutshup,
      required int countMayounez,
      required int countHarissa,
      required int countOuef,
      required int itemFoodId,
    }) async {
  try {
    await supabase.from(Table_Food_Detail).insert({
      'cutshup': countCutshup,
      'mayounez': countMayounez,
      'harissa': countHarissa,
      'ouef': countOuef,
      'item_food_id': itemFoodId
    });
  } catch (error) {
    print('Error AddDetailDataBase : $error');
    rethrow;
  }
}
