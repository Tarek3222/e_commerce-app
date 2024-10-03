import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/views/widgets/accout_tab.dart';
import 'package:e_commerce_app/views/widgets/carts_body_tab.dart';
import 'package:e_commerce_app/views/widgets/category_body_tab.dart';

import 'package:e_commerce_app/views/widgets/custom_bottom_nav_bar.dart';
import 'package:e_commerce_app/views/widgets/home_view_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String homeViewId = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<Widget> screens = const [
    HomeViewBody(),
    CategoryBodyTab(),
    CartsBodyTab(),
    AccountTab(),
  ];

  @override
  void initState() {
    BlocProvider.of<ProductsCartCubit>(context).loadProducts();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
