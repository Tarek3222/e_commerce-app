import 'dart:io';

import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:e_commerce_app/core/widget/custom_text_form_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String? productName,
      productDescription,
      productImage,
      productPrice,
      productBrand,
      productQuantity;
  String productCategory = kCategories[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () async {
              final file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              setState(() {
                isLoading = true;
              });
              if (file == null) return;
              String fileName =
                  DateTime.now().microsecondsSinceEpoch.toString();
              // Create a reference to the location you want to upload to in Firebase Storage
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');
              // Create a Reference to the file you want to upload
              Reference referenceImageToUpload =
                  referenceDirImages.child(fileName);
              // Upload the file to firebase
              try {
                await referenceImageToUpload.putFile(File(file.path));
                productImage = await referenceImageToUpload.getDownloadURL();
                setState(() {
                  isLoading = false;
                });
                showSnackBar(context, 'Image added', Colors.green);
              } catch (e) {
                showSnackBar(context, e.toString(), Colors.red);
              }
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: productImage != null
                  ? NetworkImage(productImage!)
                  : Image.asset('assets/images/not_found.png').image,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            hintText: 'Product Name',
            onChanged: (data) {
              productName = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            inputType: TextInputType.number,
            hintText: 'Product Price',
            onChanged: (data) {
              productPrice = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product price';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            hintText: 'Product Description',
            onChanged: (data) {
              productDescription = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            inputType: TextInputType.number,
            hintText: 'Product Quantity',
            onChanged: (data) {
              productQuantity = data;
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter product quantity';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Autocomplete(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return kBrands.where((String option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String value) {
              setState(() {
                productBrand = value;
              });
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (String value) {
                  onFieldSubmitted();
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter product brand';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Product Brand',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Category : ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                    iconEnabledColor: Colors.white,
                    dropdownColor: AppColors.myGrey,
                    value: productCategory,
                    items: [
                      for (final category in kCategories)
                        DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        productCategory = value!;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: CustomButton(
              text: 'Add Product',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (productImage == null) {
                    Fluttertoast.showToast(msg: 'Please add product image');
                    return;
                  }
                  addProduct();
                  formKey.currentState!.reset();
                  autovalidateMode = AutovalidateMode.disabled;
                  productImage = null;
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void addProduct() {
    ProductModel productModel = ProductModel(
      brand: productBrand!,
      name: productName!,
      price: productPrice!,
      description: productDescription!,
      category: productCategory,
      quantity: productQuantity!,
      imageLocation: productImage!,
    );
    StoreService().addProduct(product: productModel);
    Fluttertoast.showToast(
      msg: 'Product added successfully',
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
