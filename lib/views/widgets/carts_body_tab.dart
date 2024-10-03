import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_states.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartsBodyTab extends StatefulWidget {
  const CartsBodyTab({super.key});

  @override
  State<CartsBodyTab> createState() => _CartsBodyTabState();
}

class _CartsBodyTabState extends State<CartsBodyTab> {
  String? address;
  @override
  void initState() {
    BlocProvider.of<ProductsCartCubit>(context).loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'unknown';
    return BlocBuilder<ProductsCartCubit, States>(
      builder: (context, state) {
        List<ProductModel> allProducts =
            BlocProvider.of<ProductsCartCubit>(context).products;
        List<ProductModel> products = [];
        for (var product in allProducts) {
          if (product.userId == email) {
            products.add(product);
          }
        }
        double heightScreen = MediaQuery.of(context).size.height;
        double heightAppBar = AppBar().preferredSize.height;
        double heightStatusBar = MediaQuery.of(context).padding.top;
        return Padding(
          padding: EdgeInsets.only(
              left: heightScreen * 0.01,
              right: heightScreen * 0.01,
              bottom: heightScreen * 0.01),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'CART',
                          colors: [
                            Colors.black,
                            Colors.blue,
                            Colors.yellow,
                            Colors.red,
                          ],
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  products.isEmpty
                      ? Container(
                          height: heightScreen -
                              heightAppBar -
                              heightStatusBar -
                              90,
                          alignment: Alignment.center,
                          child: const Text(
                            'Cart is empty',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return itemCart(
                                  context, heightScreen, products[index],
                                  onTapUp: (details) {
                                showShortMenu(
                                    context, details, products[index]);
                              });
                            },
                            itemCount: products.length,
                          ),
                        ),
                  if (products.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: CustomButton(
                          text: 'Order',
                          onPressed: () {
                            showCustomDialog(products, context);
                          }),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemCart(context, double heightScreen, ProductModel product,
      {void Function(TapUpDetails)? onTapUp}) {
    return GestureDetector(
      onTapUp: onTapUp,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(
          top: heightScreen * 0.01,
        ),
        height: heightScreen * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: heightScreen * 0.12 / 2,
            backgroundImage: Image.network(product.imageLocation).image,
          ),
          title: Text(
            product.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            'price: \$${int.parse(product.price) * product.quantityInCart!}',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          trailing: Text(
            product.quantityInCart.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  showShortMenu(
      BuildContext context, TapUpDetails details, ProductModel product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.height - dy;
    await showMenu(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          PopupMenuItem(
            value: 'Delete',
            child: const Text('Delete'),
            onTap: () {
              try {
                BlocProvider.of<ProductsCartCubit>(context)
                    .removeProductFromCart(product);
                Fluttertoast.showToast(
                    msg: 'Product deleted successfully',
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    toastLength: Toast.LENGTH_SHORT);
              } catch (e) {
                Fluttertoast.showToast(
                    msg: 'Something went wrong',
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    toastLength: Toast.LENGTH_SHORT);
              }
            },
          ),
        ]);
  }

  showCustomDialog(List<ProductModel> products, BuildContext context) async {
    var totalPrice = getTotalPrice(products);
    AlertDialog alert = AlertDialog(
      title: Text(
        'Total price= \$$totalPrice',
        style: const TextStyle(fontSize: 18),
      ),
      content: TextField(
        onChanged: (data) {
          address = data;
        },
        decoration: const InputDecoration(
          hintText: 'Enter Your Address',
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Order'),
          onPressed: () {
            try {
              StoreService().storeOrders({
                kTotalPrice: totalPrice,
                kAddress: address,
              }, products);
              Navigator.of(context).pop();
              showSnackBar(context, 'Order placed successfully', Colors.green);
            } catch (e) {
              showSnackBar(context, e.toString(), Colors.red);
            }
          },
        ),
      ],
    );
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getTotalPrice(List<ProductModel> products) {
    var totalPrice = 0.0;
    for (var product in products) {
      totalPrice += num.parse(product.price) * product.quantityInCart!;
    }
    return totalPrice;
  }
}
