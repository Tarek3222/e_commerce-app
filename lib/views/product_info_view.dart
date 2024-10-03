import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({
    super.key,
    required this.product,
  });
  static const String id = "ProductInfoView";
  final ProductModel product;

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'unknown';
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 16,
                ),
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          width: 150,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF212325),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count <
                                        int.parse(widget.product.quantity)) {
                                      count++;
                                    } else {
                                      showSnackBar(
                                          context,
                                          'Quantity must be less than or equal to ${widget.product.quantity}',
                                          AppColors.myGrey);
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '$count',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 3,
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
                                          AppColors.myGrey);
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
                      height: 15,
                    ),
                    Text(
                      "Brand: ${widget.product.brand}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.6),
                        letterSpacing: 1.5,
                      ),
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
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      text: "Add To Cart",
                      onPressed: () async {
                        widget.product.quantityInCart = count;
                        widget.product.userId = email;
                        List<ProductModel> allProducts =
                            BlocProvider.of<ProductsCartCubit>(context)
                                .products;
                        List<ProductModel> productsInCart = [];
                        for (var product in allProducts) {
                          if (product.userId == email) {
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
                          await StoreService()
                              .updateProduct(product: widget.product);
                          await BlocProvider.of<ProductsCartCubit>(context)
                              .loadProducts();
                          showSnackBar(
                              context, 'Product added to cart', Colors.green);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 360,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      leading: const BackButton(
        color: AppColors.myWhite,
      ),
      backgroundColor: AppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
              color: AppColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        background: Hero(
          tag: widget.product.imageLocation,
          child: Image(
            image: NetworkImage(widget.product.imageLocation),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
