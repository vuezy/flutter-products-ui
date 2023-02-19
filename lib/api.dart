import 'package:dio/dio.dart';
import 'package:flutter_products_ui/models/product_model.dart';

abstract class Api {
  static Future<List<Product>> fetchProducts(int skip, int limit) async {
    final response = await Dio().get('https://dummyjson.com/products?skip=$skip&limit=$limit');
    final List<dynamic> products = response.data['products'];
    return products.map((product) => Product.fromJson(product)).toList();
  }
}