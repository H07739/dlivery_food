import 'package:flutter/material.dart';
import 'package:my_project/main.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../../strings.dart';

class AddDetailView extends StatefulWidget {
  AddDetailView({super.key});

  @override
  _AddDetailViewState createState() => _AddDetailViewState();
}

class _AddDetailViewState extends State<AddDetailView> {
  TextEditingController detailNameController = TextEditingController();
  TextEditingController detailPriceController = TextEditingController();

  String? nameError;
  String? priceError;

  Future<void> _validateAndSubmit(ValueNotifier<bool> keyNotifier) async {
    setState(() {
      nameError = detailNameController.text.isEmpty ? "This field is required" : null;
      priceError = detailPriceController.text.isEmpty ? "This field is required" : null;
    });

    if (nameError == null && priceError == null) {
      try {
        keyNotifier.value = true;

        await supabase.from(Table_Detail).insert({
          'name': detailNameController.text,
          'price': detailPriceController.text,
          'admin':supabase.auth.currentUser!.id
        });


        detailNameController.clear();
        detailPriceController.clear();


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Add Detail successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add detail. Error: $e')),
        );
      } finally {
        keyNotifier.value = false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            TextField(
              keyboardType: TextInputType.text,
              controller: detailNameController,
              decoration: InputDecoration(
                helperText: "Detail Name",
                errorText: nameError,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            Divider(),
            TextField(
              keyboardType: TextInputType.number,
              controller: detailPriceController,
              decoration: InputDecoration(
                helperText: "Detail Price",
                errorText: priceError,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MaterialButtonX(
                    text: Text(
                      'Add Detail',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _validateAndSubmit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
