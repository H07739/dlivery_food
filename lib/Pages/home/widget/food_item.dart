import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/widgets/image_view.dart';

import '../../../widgets/favorite_item.dart';
import '../function/add_favorite.dart';
import '../view/food_detail_view.dart';

class FoodItem extends StatelessWidget {
  FoodItem({super.key,required this.model});
  FoodModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26,blurRadius: 10,spreadRadius: 2)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Get.to(ProductDetailPage(product: model,));
            },
            child: ClipRRect(
              
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: ImageView(url: model.image,width: double.infinity,
                height: 150,),

            
            ),
          ),
          Padding(padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 4,),
                Text(model.category,style: TextStyle(fontSize: 14,color: Colors.grey),),
                const SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${model.price} D',style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),),


                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: (){
                      Get.to(ProductDetailPage(product: model,));
                    }, child: Text('View')),
                    Spacer(),
                    FavoriteItem(like: model.is_favorite, onPressed: (bool like) async{
                      if(!like){
                        removeFavorite(model: model, context: context);
                      }
                      else{
                        addFavorite(model: model, context: context);
                      }
                    },),
                  ],
                ),
                Divider(),
                Text(model.description,style: TextStyle(color: Colors.grey),)
              ],
            ),
          ),


        ],
      ),
    );

  }
}

