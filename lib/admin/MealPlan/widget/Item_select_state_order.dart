import 'package:flutter/cupertino.dart';

class ItemSelectStateOrder extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemSelected;

  const ItemSelectStateOrder({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  State<ItemSelectStateOrder> createState() => _ItemSelectStateOrderState();
}

class _ItemSelectStateOrderState extends State<ItemSelectStateOrder> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      selectedItem = widget.items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.items.map((item) {
            bool isSelected = item == selectedItem;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = item;
                });
                widget.onItemSelected(item);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
