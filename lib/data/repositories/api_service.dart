import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
        return products;
      } else {
        throw "Failed to load products";
      }
    } catch (e) {
      throw "Error fetching products: $e";
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/categories'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<String> categories = body.map((dynamic item) => item.toString()).toList();
        return categories;
      } else {
        throw "Failed to load categories";
      }
    } catch (e) {
      throw "Error fetching categories: $e";
    }
  }
}