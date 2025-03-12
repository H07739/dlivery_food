import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/widgets/image_view.dart';

class ImageFoodDetail extends StatelessWidget {
  ImageFoodDetail({super.key,required this.product});
  FoodModel product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ImageView(
        url: product.image,
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
