import 'package:get/get.dart';

import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
  }

  void setNotifications(List<NotificationModel> newList) {
    notifications.value = newList;
  }
}
