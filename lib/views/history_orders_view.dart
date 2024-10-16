import 'package:e_commerce_app/views/widgets/history_orders_body.dart';
import 'package:flutter/material.dart';

class HistoryOrdersView extends StatelessWidget {
  const HistoryOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Orders History',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const HistoryOrdersBody(),
    );
  }
}
