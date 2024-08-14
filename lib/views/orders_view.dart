import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/orders_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/order_details_view.dart';
import 'package:e_commerce_app/views/widgets/headers.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});
  static const String id = 'orders_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: StoreService().loadOrders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('No Orders Found');
            } else {
              List<OrdersModel> ordersList = [];
              for (var doc in snapshot.data!.docs) {
                ordersList.add(OrdersModel(
                  totalPrice: doc.get(kTotalPrice),
                  address: doc.get(kAddress),
                  id: doc.id,
                ));
              }

              return Column(
                children: [
                  const Headers(title: 'Orders'),
                  ordersList.isEmpty
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'No Orders Found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ordersList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      'TotalPrice= \$${ordersList[index].totalPrice}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      'Address is ${ordersList[index].address}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, OrderDetailsView.id,
                                            arguments: ordersList[index]);
                                      },
                                      child: const Icon(
                                        Icons.details,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              );
            }
          }),
    );
  }
}
