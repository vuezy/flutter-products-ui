import 'package:flutter/material.dart';
import 'package:flutter_products_ui/widgets/filter_dialog.dart';
import 'package:flutter_products_ui/widgets/products.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<String> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)
          )
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu)
        ),
        title: const Text('Our Products', style: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold
        )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined)
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade300,
                  Colors.green.shade100,
                ]
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black12, offset: Offset(0.0, -15.0), blurRadius: 15.0)
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.green.shade900,
                          offset: const Offset(-2.0, 0.0),
                          blurRadius: 10.0
                        )
                      ]
                    )),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => FilterDialog(
                            selectedCategories: _selectedCategories,
                            onApplied: (List<String> categories) {
                              setState(() {
                                _selectedCategories = categories;
                              });
                            },
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)
                        )
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.settings),
                          SizedBox(width: 5.0,),
                          Text('Filter')
                        ],
                      )
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (_selectedCategories.isEmpty || _selectedCategories.length == 10)
                      _buildCategoryChip('All')
                      else
                      ..._selectedCategories.map((category) => _buildCategoryChip(category)).toList()
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
      body: Products(categories: _selectedCategories),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Row(
      children: [
        Chip(
          label: Text(label),
          side: const BorderSide(color: Colors.green),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 8.0,)
      ],
    );
  }
}