import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/food_item.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../../../color.dart';
import '../function/getFoodfavoriteLocal.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favoriteItem = [
    {
      'image':
          'https://www.piclumen.com/wp-content/uploads/2024/10/piclumen-upscale-after.webp',
      'name': 'image test',
      'cal': 'test test test',
      'time': '10:pm',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilderX<List<FoodModel>>(
        future: () => getFoodFavoriteLocal(),
        loadingView: const Center(
          child: CircularProgressIndicator(),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier) {
          return Text(error);
        },
        doneView: (List<FoodModel> data, ValueNotifier<int> keyNotifier) {
          return ListView.builder(
            itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FoodItem(model: data[index]),
            );
          });
        },
      ),
    );
  }
}
