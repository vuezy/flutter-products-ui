import 'package:flutter/material.dart';
import 'package:flutter_products_ui/api.dart';
import 'package:flutter_products_ui/models/product_model.dart';
import 'package:flutter_products_ui/views/product_detail.dart';

class Products extends StatefulWidget {
  final List<String> categories;
  const Products({super.key, required this.categories});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool _isLastData = false;
  bool _isError = false;
  int _skipData = 0;
  int _limitData = 6;
  final int _nextDataTrigger = 2;
  final List<Product> _productList = [];

  void _fetchProducts() async {
    try {
      if (_skipData == 48) _limitData = 2;

      final products = await Api.fetchProducts(_skipData, _limitData);
      setState(() {
        _isLastData = _skipData == 48;
        if (!_isLastData) _skipData += 6;
        _productList.addAll(products);
      });
    }
    catch (e) {
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProductList = _productList.where((product) {
      if (widget.categories.isEmpty) return true;
      if (widget.categories.contains(product.category)) return true;
      return false;
    }).toList();

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.0,
        childAspectRatio: 10.0 / 15.0
      ),
      itemCount: filteredProductList.length + (_isLastData ? 0 : 1),
      itemBuilder: (context, index) {
        if (
          (index == filteredProductList.length - _nextDataTrigger || filteredProductList.isEmpty) 
          && !_isLastData
        ) {
          _fetchProducts();
        }

        if (index == filteredProductList.length) {
          if (_isError) {
            return _buildLoadingAndErrorCard(
              content: Center(
                child: Text(
                  'ERROR!!! Please try again!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            );
          }
          else {
            return _buildLoadingAndErrorCard(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 5.0,),
                  Text('Loading...', style: TextStyle(color: Colors.green.shade800))
                ],
              )
            );
          }
        }
        
        final product = filteredProductList[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildLoadingAndErrorCard({required Widget content}) {
    return _buildCard(
      color: Colors.white54,
      elevation: 0.0,
      onTap: () {},
      content: content
    );
  }

  Widget _buildProductCard(Product product) {

    return _buildCard(
      color: Colors.white.withOpacity(0.85),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProductDetail(product: product);
        }));
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.fill,
                height: 90.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(product.title, style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold
          )),
          const SizedBox(height: 5.0,),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.blueGrey.shade600,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(text: ' \$${product.price} ', style: const TextStyle(
                  decoration: TextDecoration.lineThrough
                )),
                TextSpan(text: ' \$${product.discountPrice}\n', style: TextStyle(
                  color: Colors.lightGreen.shade700,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w900
                )),
                TextSpan(text: '(${product.discount}% off)', style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900
                ))
              ]
            )
          )
        ],
      ),
    );
  }

  Widget _buildCard({
    required Widget content,
    required void Function() onTap,
    required Color color,
    double elevation = 5.0
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content
        ),
      ),
    );
  }
}