import 'package:my_project/Pages/notification/model/notification_model.dart';
import 'package:my_project/main.dart';
import '../../../strings.dart';

Future<List<NotificationModel>> getNotification() async {
  try {
    final List<Map<String, dynamic>> notifications = await supabase
        .from(Table_Notification)
        .select('*')
        .eq('id_receive', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);

    return notifications
        .map((json) => NotificationModel.fromJson(json))
        .toList();
  } catch (e) {
    print('Error getting notification: $e');
    rethrow;
  }
}
