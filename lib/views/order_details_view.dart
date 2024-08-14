import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/orders_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:e_commerce_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});
  static const String id = 'order_details_view';

  @override
  Widget build(BuildContext context) {
    OrdersModel order = ModalRoute.of(context)!.settings.arguments as OrdersModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: StoreService().loadOrdersDetails(order.id!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> products = [];
              for (var doc in snapshot.data!.docs) {
                products.add(ProductModel(
                  description: '',
                  quantity: '',
                  name: doc.get(kProductName),
                  price: doc.get(kProductPrice),
                  id: doc.id,
                  category: doc.get(kProductCategory),
                  quantityInCart: doc.get(kQuantityInCart),
                  imageLocation: doc.get(kProductLocation),
                ));
              }

              return Column(
                children: [
                  const Headers(title: 'Orders Details'),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: MediaQuery.of(context).size.height * 0.20,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: Image
                                    .network(products[index].imageLocation)
                                    .image,
                              ),
                              title: Text(
                                'Name: ${products[index].name}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category: ${products[index].category}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    'Price: \$${products[index].price}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    'Quantity: ${products[index].quantityInCart}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                    child: Row(
                      children: [
                        Expanded(child: CustomButton(text: 'Cancel', onPressed: ()async{
                          await StoreService().cancelOrder(order);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: 'Order Cancelled');
                        },)),
                        const SizedBox(width: 5,),
                        Expanded(child: CustomButton(text: 'Confirm ', onPressed: ()async{
                          order.statusOrder = 'Confirmed';
                          await StoreService().updateOrder(order: order);
                          Fluttertoast.showToast(msg: 'Order Confirmed');
                        },)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                ],
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}
