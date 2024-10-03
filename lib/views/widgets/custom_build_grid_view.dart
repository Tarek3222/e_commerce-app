import 'package:e_commerce_app/features/admin/presentation/views/widgets/custom_card_product.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:flutter/material.dart';

class CustomBuildGridView extends StatelessWidget {
  const CustomBuildGridView({super.key, required this.productList});
  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  }
}
