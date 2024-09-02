import 'dart:convert';

import 'package:bookstore/features/pages/usecase/product.model.dart';
import 'package:bookstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAppProductProvider extends ChangeNotifier {
  List<Data> _products = []; // Store the list of Data (products) instead
  List<Data> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$BASE_URL/api/products'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ProductModel productModel = ProductModel.fromJson(data);

        if (productModel.data != null) {
          _products = productModel.data!;
        } else {
          _products = [];
        }
      } else {
        _products = [];
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
