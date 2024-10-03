import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/edit_product_form.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/headers.dart';
import 'package:flutter/material.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({
    super.key,
  });

  static const String id = 'edit_product_view';

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Headers(title: 'Edit Product'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: EditProductForm(
                productModel: productModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
