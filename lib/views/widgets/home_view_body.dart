import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/admin/presentation/views/widgets/custom_card_product.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/all_products_view.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:e_commerce_app/views/widgets/category_tile.dart';
import 'package:e_commerce_app/views/widgets/custom_app_bar.dart';
import 'package:e_commerce_app/views/widgets/custom_offer.dart';
import 'package:e_commerce_app/views/widgets/product_by_brand.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<ProductModel> productList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                products: productList,
              ),
              const CustomOffer(),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shop by Category',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: [
                  categoryTile(context, kAndroidMobileCategory,
                      'assets/images/android_mobile.jpg'),
                  categoryTile(
                      context, kIphoneCategory, 'assets/images/iphone1.jpg'),
                  categoryTile(
                      context, kTabletsCategory, 'assets/images/tablets.jpg'),
                  categoryTile(
                      context, kLabtopsCategory, 'assets/images/labtops.jpg'),
                ],
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shop by Brand',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: [
                  _brandTile(
                      context, kSamsungBrand, 'assets/images/samsung.jpg'),
                  _brandTile(context, kAppleBrand, 'assets/images/ios.jpg'),
                  _brandTile(context, kSonyBrand, 'assets/images/sony.jpg'),
                  _brandTile(context, kXiaomiBrand, 'assets/images/xiaomi.jpg'),
                  _brandTile(context, kHuaweiBrand, 'assets/images/huawei.jpg'),
                  _brandTile(context, kDellBrand, 'assets/images/dell.jpg'),
                  _brandTile(context, kHpBrand, 'assets/images/hp.jpg'),
                  _brandTile(context, kNokiaBrand, 'assets/images/nokia.jpg'),
                  _brandTile(context, kLenovoBrand, 'assets/images/lenovo.jpg'),
                  _brandTile(context, kOppoBrand, 'assets/images/oppo.jpg'),
                  _brandTile(context, kRealmeBrand, 'assets/images/relme.jpg'),
                  _brandTile(context, kVivoBrand, 'assets/images/vivo.jpg'),
                  _brandTile(
                      context, kOthersBrand, 'assets/images/otherss.jpg'),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    'discover Products',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllProductsView(
                            products: productList,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View All >',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              _productsBuild(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _brandTile(BuildContext context, String brandName, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsByBrand(
              brand: brandName,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: Image.asset(imagePath).image,
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: brandName == kOthersBrand
            ? Center(
                child: Text(
                  brandName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            : const Text(''),
      ),
    );
  }

  Widget _productsBuild(BuildContext context) {
    return StreamBuilder(
      stream: StoreService().loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            ProductModel product = ProductModel(
              brand: doc.get(kProductBrand),
              name: doc.get(kProductName),
              price: doc.get(kProductPrice),
              id: doc.id,
              description: doc.get(kProductDescription),
              category: doc.get(kProductCategory),
              quantity: doc.get(kProductQuantity),
              imageLocation: doc.get(kProductLocation),
            );
            if (!productList.contains(product)) {
              productList.add(product);
            }
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
