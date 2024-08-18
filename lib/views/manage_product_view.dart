import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/edit_product_view.dart';
import 'package:e_commerce_app/views/widgets/custom_card_product.dart';
import 'package:e_commerce_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ManageProductView extends StatelessWidget {
  const ManageProductView({super.key});
  static const String id = 'manage_product_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: StoreService().loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> productList = [];
            for (var doc in snapshot.data!.docs) {
              productList.add(ProductModel(
                name: doc.get(kProductName),
                price: doc.get(kProductPrice),
                id: doc.id,
                description: doc.get(kProductDescription),
                category: doc.get(kProductCategory),
                quantity: doc.get(kProductQuantity),
                imageLocation: doc.get(kProductLocation),
              ));
            }
            return Column(
                children: [
                  const Headers(title: 'Manage Products'),
                productList.isEmpty ?  Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'No Products Found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ) :  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 70),
                      children:[ GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 100,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return CustomCardProduct(
                            backgroundColor: Colors.black,
                            titleColor: kPrimaryColor,
                            subtitleColor: Colors.white,
                            product: productList[index],
                            onTap: (details) async {
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
                                      value: 'Edit',
                                      child: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pushNamed(context, EditProductView.id,
                                            arguments: productList[index]);
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: 'Delete',
                                      child: const Text('Delete'),
                                      onTap: () async {
                                        await StoreService()
                                            .deleteProduct(id: productList[index].id!);
                                        Fluttertoast.showToast(
                                            msg: 'Deleted successfully',
                                            backgroundColor: kPrimaryColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                            toastLength: Toast.LENGTH_SHORT);
                                      },
                                    ),
                                  ]);
                            },
                          );
                        },
                      ),],
                    ),
                  ),
                ],
              );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
