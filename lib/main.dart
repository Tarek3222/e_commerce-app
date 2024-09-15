import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:e_commerce_app/features/splash/presentation/views/splash_view.dart';
import 'package:e_commerce_app/views/add_product_view.dart';
import 'package:e_commerce_app/views/admin_home_view.dart';
import 'package:e_commerce_app/views/cart_view.dart';
import 'package:e_commerce_app/views/edit_product_view.dart';
import 'package:e_commerce_app/views/manage_product_view.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/views/log_in_view.dart';
import 'package:e_commerce_app/views/order_details_view.dart';
import 'package:e_commerce_app/views/orders_view.dart';
import 'package:e_commerce_app/views/sign_up_user_or_admin.dart';
import 'package:e_commerce_app/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
        ),
        routes: routes,
        initialRoute: SplashView.splashViewId,
      ),
    );
  }
}

Map<String, Widget Function(BuildContext)> routes = {
  SplashView.splashViewId: (context) => const SplashView(),
  OnboardingView.onboardingViewId: (context) => const OnboardingView(),
  LogInView.loginVeiwId: (context) => const LogInView(),
  SignUpView.signUpViewId: (context) => const SignUpView(),
  HomeView.homeViewId: (context) => const HomeView(),
  AdminHomeView.id: (context) => const AdminHomeView(),
  AddProductView.id: (context) => const AddProductView(),
  ManageProductView.id: (context) => const ManageProductView(),
  EditProductView.id: (context) => const EditProductView(),
  CartView.id: (context) => const CartView(),
  OrdersView.id: (context) => const OrdersView(),
  OrderDetailsView.id: (context) => const OrderDetailsView(),
  SignUpUserOrAdmin.id: (context) => const SignUpUserOrAdmin(),
};
