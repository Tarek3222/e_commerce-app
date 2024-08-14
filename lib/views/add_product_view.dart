import 'package:e_commerce_app/views/widgets/add_product_form.dart';
import 'package:e_commerce_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const String id = 'add_product_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
             Headers(title: 'Add Product'),
            Padding(
              padding:  EdgeInsets.symmetric(
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
