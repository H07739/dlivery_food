import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/image_food_detail.dart';
import 'package:my_project/widgets/favorite_item.dart';
import 'package:my_project/widgets/image_view.dart';

import '../model/food_detail_model.dart';
import '../widget/food_detail_info.dart';

// class ProductDetailPage extends StatefulWidget {
//   final FoodModel product;
//
//   const ProductDetailPage({super.key, required this.product});
//
//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }
//
// class _ProductDetailPageState extends State<ProductDetailPage> {
//   int _quantity = 1;
//   int _cartItemCount = 0;
//   Map<String, bool> _options = {
//     "add fromage ": false,
//     "add frites": false,
//     "add drink": false,
//   };
//   late double _basePrice;
//   double _totalPrice = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _basePrice = double.tryParse(widget.product.price) ?? 0.0;
//     _totalPrice = _basePrice;
//   }
//
//   void _updateTotalPrice() {
//     double optionsPrice = _options.values.where((value) => value).length * 6;
//     setState(() {
//       _totalPrice = (_basePrice + optionsPrice) * _quantity;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(widget.product.name, style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.deepOrange,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.shopping_cart, color: Colors.white),
//                 onPressed: () {},
//               ),
//               if (_cartItemCount > 0)
//                 Positioned(
//                   right: 8,
//                   top: 8,
//                   child: Container(
//                     padding: EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       '$_cartItemCount',
//                       style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.only(bottom: 80),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       widget.product.image,
//                       height: 250,
//                       width: MediaQuery.of(context).size.width,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ), // image product
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               widget.product.name,
//                               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               FavoriteItem(
//                                 like: widget.product.is_favorite,
//                                 onPressed: (bool state) {
//                                   setState(() {
//                                     widget.product.is_favorite = state;
//                                     if (state) {
//                                       widget.product.addFood(widget.product);
//                                     } else {
//                                       widget.product.removeFood(widget.product.id);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${_totalPrice.toStringAsFixed(2)} D",
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange),
//                           ),
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.remove),
//                                 onPressed: () {
//                                   if (_quantity > 1) {
//                                     setState(() {
//                                       _quantity--;
//                                       _updateTotalPrice();
//                                     });
//                                   }
//                                 },
//                               ),
//                               Text(
//                                 "$_quantity",
//                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.add),
//                                 onPressed: () {
//                                   setState(() {
//                                     _quantity++;
//                                     _updateTotalPrice();
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         "Options Supplémentaires",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Column(
//                         children: _options.keys.map((option) {
//                           return CheckboxListTile(
//                             title: Row(
//                               children: [
//                                 Text(option),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "6D",
//                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
//                                 ),
//                               ],
//                             ),
//                             value: _options[option],
//                             activeColor: Colors.deepOrange,
//                             onChanged: (bool? value) {
//                               if (value != null) {
//                                 setState(() {
//                                   _options[option] = value;
//                                   _updateTotalPrice();
//                                 });
//                               }
//                             },
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ), // information product
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(12),
//               color: Colors.white,
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _cartItemCount += _quantity;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepOrange,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                     textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       side: BorderSide(color: Colors.deepOrange),
//                     ),
//                   ),
//                   child: Text("Ajouter au panier"),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProductDetailPage extends StatelessWidget {
  FoodModel product;
  ProductDetailPage({super.key, required this.product});

  ValueNotifier<List<FoodDetailModel>> details = ValueNotifier([
    FoodDetailModel(name: 'Cutshup', pirec: 6, check: false),
    FoodDetailModel(name: 'Mayounez', pirec: 8, check: false),
    FoodDetailModel(name: 'Harissa', pirec: 4, check: false),
    FoodDetailModel(name: 'Ouef', pirec: 5, check: false),
  ]);

  ValueNotifier<double> pirce = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    pirce.value=double.tryParse(product.price) ?? 0.0;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(product.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(

              children: [
                ImageFoodDetail(product: product,),
                FoodDetailInfo(product: product, pirce: pirce,),
                ValueListenableBuilder<List<FoodDetailModel>>(
                  valueListenable: details,
                  builder: (BuildContext context, List<FoodDetailModel> value, Widget? child) {
                    return Column(
                      children: [
                        for (var i = 0; i < value.length; i++)
                          Row(
                            children: [
                              Checkbox(
                                value: value[i].check,
                                onChanged: (bool? newValue) {
                                  if (newValue != null) {
                                    // تحديث الحالة
                                    value[i].check = newValue;
                                    if (newValue) {
                                      pirce.value += value[i].pirec; // إضافة السعر عند التحديد
                                    } else {
                                      pirce.value -= value[i].pirec; // خصم السعر عند الإلغاء
                                    }

                                    // تحديث `details` ليعكس التغيير
                                    details.value = List.from(value);
                                  }
                                },
                              ),
                              SizedBox(width: 8),
                              Text(
                                value[i].name,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${value[i].pirec} D",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(12),

                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                        ),
                        child: Text("Ajouter au panier"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )],
      ),
    );
  }
}
