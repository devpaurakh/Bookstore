import 'package:bookstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDeleteProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _message = '';
  String get message => _message;

  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await http.delete(Uri.parse('$BASE_URL/api/products/$id'));
      if (response.statusCode == 200) {
        _message = 'Product deleted successfully';
        notifyListeners();
      } else {
        _message = 'Failed to delete product';
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
