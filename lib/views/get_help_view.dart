import 'package:e_commerce_app/views/widgets/get_help_body.dart';
import 'package:flutter/material.dart';

class GetHelpView extends StatelessWidget {
  const GetHelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Get Help',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const GetHelpBody(),
    );
  }
}
