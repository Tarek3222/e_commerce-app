import 'package:e_commerce_app/features/admin/presentation/views/widgets/custom_card_product.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/product_info_view.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<ProductModel> filteredProducts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextField(onChanged: (productName) {
                  setState(() {
                    if (productName.isEmpty) {
                      filteredProducts = [];
                    } else {
                      filteredProducts = widget.products
                          .where(
                            (product) => product.name.toLowerCase().startsWith(
                                  productName.toLowerCase(),
                                ),
                          )
                          .toList();
                    }
                  });
                }),
                filteredProducts.isEmpty
                    ? const SizedBox(
                        height: 600,
                        child: Center(
                          child: Text(
                            'No Products',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 2, right: 2),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 1,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return CustomCardProduct(
                                onTap: (details) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductInfoView(
                                        product: filteredProducts[index],
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.black.withOpacity(0.7),
                                product: filteredProducts[index]);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({void Function(String)? onChanged}) {
    return TextField(
      cursorColor: Colors.grey,
      autofocus: true,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 20, color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
