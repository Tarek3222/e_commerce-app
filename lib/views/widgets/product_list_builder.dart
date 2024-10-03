import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/custom_card_product.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:flutter/material.dart';

class ProductsListBuilder extends StatelessWidget {
  const ProductsListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> productList = [];
          for (var doc in snapshot.data!.docs) {
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
          return productList.isEmpty
              ? const Center(
                  child: Text(
                    'No Products Found',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: productList.length > 6 ? 6 : productList.length,
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
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
