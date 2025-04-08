import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../strings.dart';
import '../controller/food_controller.dart';

Future<void> confirmDeleteFood({required int idFood, required BuildContext context,required FoodController controller}) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete this food?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Delete'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    try {
      await supabase.from(Table_Food).delete().eq('id', idFood);
      controller.deleteFood(idFood);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Food deleted successfully')),
      );
    } catch (e) {
      print('Error deleting food: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete food')),
      );
    }
  }
}
