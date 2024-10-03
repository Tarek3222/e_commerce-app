import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/widgets/custom_build_grid_view.dart';
import 'package:flutter/material.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'All Products',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CustomBuildGridView(productList: products),
    );
  }
}
