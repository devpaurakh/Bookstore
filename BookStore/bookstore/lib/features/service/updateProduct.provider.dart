import 'dart:convert';
import 'package:bookstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _message = '';
  String get message => _message;

  Future<void> updateProduct(String name, String price, String imageUrl, String id) async {
    _isLoading = true;
    notifyListeners();

    var body = {
      "name": name,
      "price": price,
      "image": imageUrl,
    };

    try {
      final response = await http.put(
        Uri.parse('$BASE_URL/api/products/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body), // Encode the map to JSON
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        _message = 'Product updated successfully';
      } else {
        _message = 'Failed to update product';
      }
    } catch (e) {
      debugPrint('Error updating product: $e');
      _message = 'Failed to update product';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
