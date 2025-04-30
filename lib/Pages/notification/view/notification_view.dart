import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/notification/controller/notification_controller.dart';
import 'package:my_project/Pages/notification/function/get_notification.dart';
import 'package:my_project/Pages/notification/model/notification_model.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../../../color.dart';
import '../widget/item_notification.dart';
class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color:textBarColor,),
        ),
        backgroundColor: backgroundColor,
      ),
      body: FutureBuilderX<List<NotificationModel>>(
        future: () => getNotification(),
        loadingView: Center(
          child: CircularProgressIndicator(),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier)=>Text(error), doneView: (List<NotificationModel> data, ValueNotifier<int> keyNotifier) {

          if(data.isEmpty){
            return Center(child: Text('Not found Notification Now'),);
          }
          controller.notifications.value = data;
          return Obx(() => ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return ItemNotification(model: controller.notifications[index],

              );
            },
          ));

      },
      ),
    );
  }
}
