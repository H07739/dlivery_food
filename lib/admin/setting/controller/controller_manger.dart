import 'package:get/get.dart';

import '../model/manger_model.dart';

class MangerController extends GetxController {
  RxList<MangerModel> managers = <MangerModel>[].obs;

  void setManagers(List<MangerModel> data) {
    managers.value = data;
  }

  void addManager(MangerModel manager) {
    managers.insert(0,manager);
  }

  void removeManagerById(int id) {
    managers.removeWhere((m) => m.id == id);
  }

  void updateManagerName(int id, String newName) {
    final index = managers.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updated = managers[index];
      managers[index] = MangerModel(
        id: updated.id,
        name: newName,
        email: updated.email,
        idUser: updated.idUser,
        createdAt: updated.createdAt,
      );
    }
  }
}
