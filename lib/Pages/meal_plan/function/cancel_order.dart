import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';

Future<void> cancelOrder({required int idOrder}) async {
  try{
    await supabase.from(Table_Requests).upsert({'statuse':'cancel'}).eq('id', idOrder);
  }catch(e){
    print('Error canceling order: $e');
   rethrow;
  }
}
