import 'dart:convert';

import 'package:bookstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _message = '';
  String get message => _message;

  Future<void> addProduct(String name, String price, String imageUrl) async {
    _isLoading = true;
    notifyListeners();
    var body = {
      "name": name,
      "price": price,
      'image': imageUrl,
    };
    try {
      final response = await http.post(
          Uri.parse(
            '$BASE_URL/api/products',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
          
      if (response.statusCode == 201) {
        _message = 'Product added successfully';
        notifyListeners();
      } else {
        _message = 'Failed to add product';
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error deleting product: $e');
      _message = 'Failed to delete product';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
