import 'package:e_commerce_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:e_commerce_app/features/splash/presentation/views/splash_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/add_product_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/admin_home_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/edit_product_view.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/features/auth/presentation/views/log_in_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/manage_product_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/order_details_view.dart';
import 'package:e_commerce_app/features/admin/presentation/views/orders_view.dart';
import 'package:e_commerce_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';

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
  OrdersView.id: (context) => const OrdersView(),
  OrderDetailsView.id: (context) => const OrderDetailsView(),
};
