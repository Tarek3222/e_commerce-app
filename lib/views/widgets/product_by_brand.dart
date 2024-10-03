import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/custom_card_product.dart';
import 'package:flutter/material.dart';

class ProductsByBrand extends StatelessWidget {
  const ProductsByBrand({super.key, required this.brand});
  final String brand;

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
          brand,
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
              if (doc.get(kProductBrand) == brand) {
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
                : Padding(
                    padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 1,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return CustomCardProduct(
                            onTap: (details) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductInfoView(
                                    product: productList[index],
                                  ),
                                ),
                              );
                            },
                            backgroundColor: Colors.black.withOpacity(0.7),
                            product: productList[index]);
                      },
                    ),
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
