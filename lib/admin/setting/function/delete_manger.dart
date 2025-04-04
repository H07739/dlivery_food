import 'package:flutter/material.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../model/manger_model.dart';

Future<void> deleteManger({
  required MangerModel model,
  required MangerController controller,
  required BuildContext context,
}) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete ${model.name}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  try {
    await supabase.from(Table_Manger).delete().eq('id', model.id);
    controller.removeManagerById(model.id);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Manager deleted successfully',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  } catch (e) {
    print('Error deleting manager: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Failed to delete manager',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }
}

