import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      controller: tabController,
      labelColor: kPrimaryColor,
      unselectedLabelColor: Colors.black,
      isScrollable: true,
      dividerColor: Colors.transparent,
      labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: kPrimaryColor, width: 3),
      ),
      tabs: const [
        Tab(text: 'Jackets'),
        Tab(text: 'Trousers'),
        Tab(text: 'Electronics'),
        Tab(text: 'shoes'),
        Tab(text: 'Accessories'),
        Tab(text: 'Watches'),
        Tab(text: 'Bags'),
        Tab(text: 'Glasses'),
        Tab(text: 'T-Shirts'),
        Tab(text: 'Others'),
      ],
    );
  }
}
