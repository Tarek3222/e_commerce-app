import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/views/cart_view.dart';
import 'package:e_commerce_app/views/log_in_view.dart';
import 'package:e_commerce_app/views/widgets/custom_app_bar.dart';
import 'package:e_commerce_app/views/widgets/custom_tab_bar.dart';
import 'package:e_commerce_app/views/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/views/widgets/products_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String homeViewId = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;



  @override
  void initState() {
    tabController = TabController(length: 10, vsync: this);
    tabController.addListener(_handleTabSelection);
    BlocProvider.of<AddProductToCartCubit>(context).loadProducts();
    setState(() {
      
    });
    super.initState();
  }

  _handleTabSelection() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String email=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                  CustomAppBar(onPressed: (){
                    Navigator.pushNamed(context, CartView.id, arguments: email);
                  },
                  logOut: ()async{
                    SharedPreferences pref=await SharedPreferences.getInstance();
                    pref.setBool(kKeepMeLoggedIn, false);
                    await AuthService().signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, LogInView.loginVeiwId);
                  },
                  ),
                const SizedBox(height: 30),
               const CustomTextFormField(hintText: 'Find Your Products',),
               CustomTabBar(tabController: tabController),
              const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                    Center(
                      child: [
                         ProductesByCategories(
                          category: kJacketsCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kTrousersCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kElectronicsCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kShoesCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kAccessoriesCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kWatchesCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kBagsCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kGlassesCategory,
                          email: email,
                        ),
                          ProductesByCategories(
                          category: kTShirtsCategory,
                          email: email,
                        ),
                         ProductesByCategories(
                          category: kOthersCategory,
                          email: email,
                        ),
                       ][tabController.index],
                    )
                    ],
                  ),
                ),
              ],
            )
            ),
      ),
    );
  }
}
