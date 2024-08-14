import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/views/add_product_view.dart';
import 'package:e_commerce_app/views/log_in_view.dart';
import 'package:e_commerce_app/views/manage_product_view.dart';
import 'package:e_commerce_app/views/orders_view.dart';
import 'package:e_commerce_app/views/widgets/custom_card_panel.dart';
import 'package:e_commerce_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});
  static const String id = 'adminHomeView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         Headers(title: 'Admin Panal',isSignOut: true,onPressed: (){
          AuthService().signOut();
          Navigator.pushReplacementNamed(context, LogInView.loginVeiwId);
        },),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                children: [
                  CustomCardPanel(
                    title: 'Add Product',
                    icon: Icons.production_quantity_limits_sharp,
                    onTap: () {
                      Navigator.pushNamed(context, AddProductView.id);
                    },
                  ),
                  CustomCardPanel(
                    title: 'Edit Product',
                    icon: Icons.mode_edit,
                    onTap: () {
                      Navigator.pushNamed(context, ManageProductView.id);
                    },
                  ),
                  CustomCardPanel(
                    title: 'View Orders',
                    icon: Icons.shopping_cart_rounded,
                    onTap: () {
                      Navigator.pushNamed(context, OrdersView.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
