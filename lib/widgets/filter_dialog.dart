import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final List<String> selectedCategories;
  final void Function(List<String>) onApplied;
  const FilterDialog({super.key, required this.selectedCategories, required this.onApplied});

  @override
  State<FilterDialog> createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  final Map<String, bool> _isSelected = {
    'Smartphones': false,
    'Laptops': false,
    'Fragrances': false,
    'Skincare': false,
    'Groceries': false,
    'Home Decoration': false,
    'Furniture': false,
    'Tops': false,
    'Womens Dresses': false,
    'Womens Shoes': false
  };

  @override
  void initState() {
    super.initState();
    for (String category in widget.selectedCategories) {
      _isSelected[category] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10.0,
      backgroundColor: Colors.green.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.black,),
            const Text('Categories', style: TextStyle(fontSize: 23.0)),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: _isSelected.keys.map((category) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0.0),
                    title: Text(category),
                    value: _isSelected[category],
                    onChanged: (value) {
                      setState(() {
                        _isSelected[category] = value!;
                      });
                    }
                  );
                }).toList()
              ),
            ),
            const SizedBox(height: 5.0,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  final List<String> selectedCategories = [];
                  for (String category in _isSelected.keys) {
                    if (_isSelected[category]!) {
                      selectedCategories.add(category);
                    }
                  }
                  widget.onApplied(selectedCategories);
                  Navigator.of(context).pop();
                },
                child: Text('Apply Filter', style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 18.0
                ))
              ),
            )
          ],
        ),
      ),
    );
  }
}