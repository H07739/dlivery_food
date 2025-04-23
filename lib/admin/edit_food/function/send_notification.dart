import 'package:my_project/main.dart';

import '../../../strings.dart';

Future<void> sendNotification(
    {required String idUser,
    required String title,
    required String body}) async {
  try {
    await supabase.from(Table_Notification).insert({
      'id_sender': supabase.auth.currentUser!.id,
      'id_receive': idUser,
      'title': title,
      'body': body
    });
    print('send notification successfull');
  } catch (er) {
    print('error in send Notification : $er');
  }
}
