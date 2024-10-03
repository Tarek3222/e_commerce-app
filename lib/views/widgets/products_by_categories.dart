import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/widgets/custom_build_grid_view.dart';
import 'package:flutter/material.dart';

class ProductesByCategories extends StatelessWidget {
  const ProductesByCategories({super.key, required this.category});
  final String category;

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
        title: Text(
          category,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: StoreService().loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> productList = [];
            for (var doc in snapshot.data!.docs) {
              if (doc.get(kProductCategory) == category) {
                productList.add(ProductModel(
                  brand: doc.get(kProductBrand),
                  name: doc.get(kProductName),
                  price: doc.get(kProductPrice),
                  id: doc.id,
                  description: doc.get(kProductDescription),
                  category: doc.get(kProductCategory),
                  quantity: doc.get(kProductQuantity),
                  imageLocation: doc.get(kProductLocation),
                ));
              }
            }
            return productList.isEmpty
                ? const Center(
                    child: Text(
                      'No Products Found',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : CustomBuildGridView(productList: productList);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
