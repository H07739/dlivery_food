import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';

class ProductDetailPage extends StatefulWidget {
  final FoodModel product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  int _cartItemCount = 0;
  bool _isFavorite = false;
  Map<String, bool> _options = {
    "add fromage ": false,
    "add frites": false,
    "add drink": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.product.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {},
              ),
              if (_cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_cartItemCount',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.product.image,
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: _isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isFavorite = !_isFavorite;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${double.parse(widget.product.price) * _quantity}D",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 1) _quantity--;
                                  });
                                },
                              ),
                              Text(
                                "$_quantity",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Options Supplémentaires",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: _options.keys.map((option) {
                          return CheckboxListTile(
                            title: Text(option),
                            value: _options[option],
                            activeColor: Colors.deepOrange,
                            onChanged: (value) {
                              setState(() {
                                _options[option] = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _cartItemCount += _quantity;
                    });
                  },
                  child: Text("Ajouter au panier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}