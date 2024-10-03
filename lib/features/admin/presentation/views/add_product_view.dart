import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/add_product_form.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/headers.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const String id = 'add_product_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myGrey.withOpacity(0.95),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Headers(title: 'Add Product'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: AddProductForm(),
            ),
          ],
        ),
      ),
    );
  }
}
