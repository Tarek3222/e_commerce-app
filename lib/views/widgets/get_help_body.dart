import 'package:e_commerce_app/views/widgets/custom_contact_us.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GetHelpBody extends StatelessWidget {
  const GetHelpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Lottie.asset(
            'assets/images/help.json',
            height: 300,
          ),
          const Text(
            'We are here to help so please get in touch with us',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomContactUs(
            title: 'Phone Number',
            subTitle: '01271845331',
            icon: Icons.phone_android,
            onTap: () {
              launchUrlString('tel:+201271845331');
            },
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 30,
          ),
          CustomContactUs(
            title: 'E-mail Address',
            subTitle: '00tarek404@gmail.com',
            icon: Icons.email_outlined,
            onTap: () {
              launchUrlString('mailto:00tarek404@gmail.com');
            },
          ),
        ],
      ),
    );
  }
}
