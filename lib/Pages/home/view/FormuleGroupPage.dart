import 'package:flutter/material.dart';

class FormuleGroupPage extends StatefulWidget {
  @override
  _FormuleGroupPageState createState() => _FormuleGroupPageState();
}

class _FormuleGroupPageState extends State<FormuleGroupPage> {
  List<String?> selectedBurgers = List.filled(3, null);
  List<String?> selectedBoissons = List.filled(2, null);
  List<String?> selectedDesserts = List.filled(4, null);

  final double pizzaPrice = 5.0;
  final double drinkPrice = 2.0;
  final double dessertPrice = 3.0;


  void _showOptions(String title, List<String> options, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: options.map((item) => ListTile(
            title: Text(item),
            onTap: () {
              onSelected(item);
              Navigator.pop(context);
            },
          )).toList(),
        );
      },
    );
  }

  Widget _buildPlatSelector(String label, int count, List<String?> selectedList, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(count, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$label ${index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (selectedList[index] != null)
                  Text("Choisi: ${selectedList[index]}", style: TextStyle(color: Colors.grey)),
              ],
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                _showOptions("$label ${index + 1}", options, (val) {
                  setState(() => selectedList[index] = val);
                });
              },
            ),
          ],
        );
      }),
    );
  }

  String getSelectedCountText() {
    int burgersCount = selectedBurgers.where((e) => e != null).length;
    int boissonsCount = selectedBoissons.where((e) => e != null).length;
    int dessertsCount = selectedDesserts.where((e) => e != null).length;

    return "$burgersCount Pizza${burgersCount != 1 ? 's' : ''}, $boissonsCount Boisson${boissonsCount != 1 ? 's' : ''}, $dessertsCount Dessert${dessertsCount != 1 ? 's' : ''}";
  }

  double calculateTotalPrice() {
    int burgersCount = selectedBurgers.where((e) => e != null).length;
    int boissonsCount = selectedBoissons.where((e) => e != null).length;
    int dessertsCount = selectedDesserts.where((e) => e != null).length;

    return (burgersCount * pizzaPrice) + (boissonsCount * drinkPrice) + (dessertsCount * dessertPrice);
  }

  Future<void> saveToSupabase() async {
    try {
      final data = {
        'burgers': selectedBurgers.where((e) => e != null).toList(),
        'boissons': selectedBoissons.where((e) => e != null).toList(),
        'desserts': selectedDesserts.where((e) => e != null).toList(),
        'prix': calculateTotalPrice(),
      };


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Formule enregistrée avec succès")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'enregistrement : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formule Group"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "  ${getSelectedCountText()} | Prix : ${calculateTotalPrice().toStringAsFixed(2)}D",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("🍔 3 Burgers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildPlatSelector("Type de burger", 3, selectedBurgers, ["Pizza", "Végétarien", "Poulet"]),
            SizedBox(height: 20),
            Text("🥤 2 Boissons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildPlatSelector("Boisson", 2, selectedBoissons, ["Coca", "Fanta", "Eau", "Sprite"]),
            SizedBox(height: 20),
            Text("🍰 4 Desserts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildPlatSelector("Dessert", 4, selectedDesserts, ["Tiramisu", "Glace", "Donut", "Fruit"]),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                int burgersCount = selectedBurgers.where((e) => e != null).length;
                int boissonsCount = selectedBoissons.where((e) => e != null).length;
                int dessertsCount = selectedDesserts.where((e) => e != null).length;

                if (burgersCount == 3 && (boissonsCount != 1 || dessertsCount != 2)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez sélectionner 1 boisson et 2 desserts pour 3 pizzas.")),
                  );
                } else if (selectedBurgers.any((e) => e == null) || selectedBoissons.any((e) => e == null) || selectedDesserts.any((e) => e == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez remplir tous les champs de la formule.")),
                  );
                } else {
                  saveToSupabase();  // Sauvegarder les données dans Supabase
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text("Valider la Formule", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}