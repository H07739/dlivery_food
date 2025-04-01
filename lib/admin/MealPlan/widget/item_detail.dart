import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/main.dart';

import '../../../strings.dart';
import '../../../widgets/MaterialButtonX.dart';
import '../../../widgets/showDialog.dart';
import '../model/detail_model.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({super.key, required this.model,required this.onDelete,required this.index});
  DetailModel model;
  final Function(int) onDelete;
  int index;
  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  void initState() {
    super.initState();
    detailNameController.text = widget.model.name;
    detailPriceController.text = widget.model.price.toString();
  }

  TextEditingController detailNameController = TextEditingController();
  TextEditingController detailPriceController = TextEditingController();

  String? nameError;
  String? priceError;

  bool _validateAndSubmit() {
    setState(() {
      nameError = detailNameController.text.trim().isEmpty
          ? "This field is required"
          : null;
      priceError = detailPriceController.text.trim().isEmpty
          ? "This field is required"
          : null;
    });

    return nameError == null && priceError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: (ValueNotifier<bool> keyNotifier) async {
                      try {
                        if (_validateAndSubmit()) {
                          keyNotifier.value= true;
                          widget.model.name = detailNameController.text;
                          widget.model.price =
                              int.parse(detailPriceController.text);
                          await supabase
                              .from(Table_Detail)
                              .update(widget.model.toJson())
                              .eq('id',widget.model.id);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'success update ',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                        else{
                          throw 'This field is required';
                        }

                      } catch (e) {
                        print('Failed to update Detail: $e');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Failder updata Detail : $e',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      finally{
                        keyNotifier.value=false;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButtonX(
                    text: Text(
                      'Deleting',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: (ValueNotifier<bool> keyNotifier) async {
                      try {
                        showDeleteDialog(
                          context: context,
                          onPressed: () async {
                            keyNotifier.value = true;
                            await supabase.from(Table_Detail).delete().eq('id', widget.model.id);

                            widget.onDelete(widget.index);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Successfully deleted',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ));

                            Get.back();
                          },
                          title: 'Deleting Detail',
                          name: 'Detail',
                        );
                      } catch (e) {
                        print('Failed to delete Detail: $e');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Failed to delete Detail: $e',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      finally{
                        keyNotifier.value = false;
                      }
                    }
                    ,
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
