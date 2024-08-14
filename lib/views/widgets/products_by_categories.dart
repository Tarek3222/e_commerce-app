import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:e_commerce_app/views/widgets/custom_card_product.dart';
import 'package:flutter/material.dart';

class ProductesByCategories extends StatelessWidget {
  const ProductesByCategories(
      {super.key, required this.category, required this.email});
  final String category;
  final String email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> productList = [];
          for (var doc in snapshot.data!.docs) {
            if (doc.get(kProductCategory) == category) {
              productList.add(ProductModel(
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
              : Padding(
                  padding: const EdgeInsets.only(top: 90, left: 2, right: 2),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 100,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return CustomCardProduct(
                          onTap: (details) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductInfoView(
                                    product: productList[index], email: email),
                              ),
                            );
                          },
                          backgroundColor: Colors.black.withOpacity(0.7),
                          titleColor: Colors.white,
                          subtitleColor: Colors.grey,
                          product: productList[index]);
                    },
                  ),
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
