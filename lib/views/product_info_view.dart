import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/cart_view.dart';
import 'package:e_commerce_app/views/widgets/app_bar_product.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({super.key, required this.product, required this.email});
  static const String id = "ProductInfoView";
  final ProductModel product;
  final String email;

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 8),
          child: Column(
            children: [
              AppBarProduct(
                onPressed: () {
                  Navigator.pushNamed(context, CartView.id, arguments: widget.email);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Image.network(
                widget.product.imageLocation,
                width: MediaQuery.of(context).size.width / 1.2,
                height: 200,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.6),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: \$${widget.product.price}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Container(
                    height: 70,
                    width: 180,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212325),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count < int.parse(widget.product.quantity)) {
                                count++;
                              } else {
                                showSnackBar(
                                    context,
                                    'Quantity must be less than or equal to ${widget.product.quantity}',
                                    kPrimaryColor);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                count--;
                              } else {
                                showSnackBar(
                                    context,
                                    'Quantity must be greater than or equal to 1',
                                    kPrimaryColor);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Avilable In Stock: ${widget.product.quantity}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Add To Cart",
                onPressed: ()async {
                  widget.product.quantityInCart = count;
                  widget.product.userId = widget.email;
                  List<ProductModel> allProducts =
                      BlocProvider.of<ProductsCartCubit>(context).products;
                  List<ProductModel> productsInCart = [];
                  for (var product in allProducts) {
                    if (product.userId == widget.email) {
                      productsInCart.add(product);
                    }
                  }
                  bool isExist = false;
                  for (var productInCart in productsInCart) {
                    if (productInCart.id == widget.product.id) {
                      isExist = true;
                      break;
                    }
                  }
                  if (isExist) {
                    showSnackBar(context, 'Product already exist in cart',
                        kPrimaryColor);
                    return;
                  } else {
                   await BlocProvider.of<ProductsCartCubit>(context)
                        .addProductToCart(widget.product);
                     await StoreService().updateProduct(product: widget.product);
                    // ignore: use_build_context_synchronously
                    await  BlocProvider.of<ProductsCartCubit>(context).loadProducts();
                  // ignore: use_build_context_synchronously
                  showSnackBar(context, 'Product added to cart', kPrimaryColor);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
