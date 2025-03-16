import 'package:flutter/material.dart';
import 'package:my_project/main.dart';

import '../model/food_model.dart';

Future<void> addFavorite(
    {required FoodModel model, required BuildContext context}) async {
  try {
    await supabase.from('Favorites').upsert(
      {
        'food_id': model.id,
        'id_user': supabase.auth.currentUser!.id,
      },
      onConflict: 'id_user, food_id',
    );
    model.is_favorite = true;
    model.addFood(model);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to favourites successfully!')),
    );
  } catch (error) {
    debugPrint('Error in Add Favorite: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding to favourites : $error')),
    );
  }
}

Future<void> removeFavorite(
    {required FoodModel model, required BuildContext context}) async {
  try {
    // حSupprimer l'enregistrement de la table Favorites où food_id et id_user correspondent.
    final response = await supabase
        .from('Favorites')
        .delete()
        .eq('food_id', model.id) // اyet2kd food
        .eq('id_user', supabase.auth.currentUser!.id); // اyt2ked mel usr mwjod
    model.is_favorite = false;
    model.removeFood(model.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed from favourites successfully!')),
    );
  } catch (error) {
    debugPrint('Error in Remove Favorite: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error removing from favourites: $error')),
    );
  }
}
