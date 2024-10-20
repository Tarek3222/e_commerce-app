import 'dart:convert';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsInCart {
  Future<void> addProductInCart(ProductModel product) async {
    http.Response response = await http.post(
        Uri.parse(
            'https://ecommerce-app-c1bdf-default-rtdb.firebaseio.com/products-cart.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          kProductBrand: product.brand,
          kProductName: product.name,
          kProductPrice: product.price,
          kProductLocation: product.imageLocation,
          kProductCategory: product.category,
          kQuantityInCart: product.quantityInCart,
          kUserId: product.userId,
          kProductId: product.id,
          kProductDescription: product.description,
          kProductQuantity: product.quantity,
        }));
    if (response.statusCode == 200) {
      product.productIdReal = json.decode(response.body)['name'];
    }
  }

  Future<List<ProductModel>> getProductsInCart() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://ecommerce-app-c1bdf-default-rtdb.firebaseio.com/products-cart.json'));
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<ProductModel> products = [];
      for (final item in jsonData.entries) {
        products.add(ProductModel(
          brand: item.value[kProductBrand],
          name: item.value[kProductName],
          price: item.value[kProductPrice],
          imageLocation: item.value[kProductLocation],
          category: item.value[kProductCategory],
          quantityInCart: item.value[kQuantityInCart],
          userId: item.value[kUserId],
          id: item.value[kProductId],
          description: item.value[kProductDescription],
          quantity: item.value[kProductQuantity],
          productIdReal: item.key,
        ));
      }
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<void> removeProductFromCart(ProductModel product) async {
    http.Response response = await http.delete(Uri.parse(
        'https://ecommerce-app-c1bdf-default-rtdb.firebaseio.com/products-cart/${product.productIdReal}.json'));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
