import 'package:flutter/material.dart';

class CustomAccountInfo extends StatelessWidget {
  const CustomAccountInfo({super.key, required this.data, required this.icon});
  final String data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            data,
            style: TextStyle(color: Colors.grey.shade600),
          )
        ],
      ),
    );
  }
}
