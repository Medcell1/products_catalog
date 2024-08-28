import 'package:hive/hive.dart';

import '../model/product_model.dart';

class ProductService {
  final Box<Product> _productBox = Hive.box('products');

  Future<void> addProduct(Product product) async {
    await _productBox.put(product.id, product);
  }

  Product? getProduct(String id) {
    return _productBox.get(id);
  }

  Future<void> updateProduct(Product product) async {
    await product.save();
  }

  Future<void> deleteProduct(String id) async {
    await _productBox.delete(id);
  }

  List<Product> getProducts({String? category}) {
    final products = _productBox.values.toList();
    if (category != null) {
      return products.where((product) => product.category == category).toList();
    }
    return products;
  }
  List<Product> getAllProducts() {
    return _productBox.values.toList();
  }
}
