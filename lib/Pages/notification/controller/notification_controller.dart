import 'package:get/get.dart';

import '../../../main.dart';
import '../../../strings.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  @override
  void onInit() async {
    super.onInit();
    List<Map<String, dynamic>> data = await supabase
        .from(Table_Notification)
        .update({'read': true}).eq('id_receive', supabase.auth.currentUser!.id);
  }

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
  }

  void setNotifications(List<NotificationModel> newList) {
    notifications.value = newList;
  }
}
