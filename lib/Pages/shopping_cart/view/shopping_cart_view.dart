import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 60), // bech ya3tiiiiiiiiiiiiii espace f bootoon
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://cdn.dribbble.com/userupload/34021260/file/original-9e892f40eced82b8e6e018f92779f180.png',
                              ),
                            ),
                            title: const Text('Food name'),
                            subtitle: const Text('10\$'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {},
                                ),
                                const Text(
                                  "4",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total : \$ 10',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.white, // couleur mte3 ariere plannnnnnnnnnnnnn
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: MaterialButtonX(
                onPressed: (ValueNotifier<bool> keyNotifier) {},
                text: const Text('CHECK OUT'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
