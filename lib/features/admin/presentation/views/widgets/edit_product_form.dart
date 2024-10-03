import 'dart:io';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:e_commerce_app/core/widget/custom_text_form_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  String? productName,
      productDescription,
      productPrice,
      productImage,
      productBrand,
      productQuantity;
  String productCategory = kCategories[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              final file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
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
                widget.productModel.imageLocation = productImage!;
                setState(() {});
                showSnackBar(context, 'Image uploaded', Colors.green);
              } catch (e) {
                showSnackBar(context, e.toString(), Colors.red);
              }
            },
            child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    NetworkImage(widget.productModel.imageLocation)),
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            hintText: widget.productModel.name,
            onChanged: (data) {
              productName = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            inputType: TextInputType.number,
            hintText: widget.productModel.price,
            onChanged: (data) {
              productPrice = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            hintText: widget.productModel.description,
            onChanged: (data) {
              productDescription = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            colorTheme: Colors.white,
            inputType: TextInputType.number,
            hintText: widget.productModel.quantity,
            onChanged: (data) {
              productQuantity = data;
            },
          ),
          const SizedBox(
            height: 15,
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
                decoration: InputDecoration(
                  hintText: widget.productModel.brand,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(
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
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    dropdownColor: const Color(0xff5A5A5A),
                    value: widget.productModel.category,
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
                        widget.productModel.category = productCategory;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
              text: 'Submit',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  update();
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Product Updated",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  update() async {
    ProductModel productModel = ProductModel(
        brand: productBrand ?? widget.productModel.brand,
        name: productName ?? widget.productModel.name,
        price: productPrice ?? widget.productModel.price,
        description: productDescription ?? widget.productModel.description,
        category: productCategory,
        quantity: productQuantity ?? widget.productModel.quantity,
        imageLocation: productImage ?? widget.productModel.imageLocation,
        id: widget.productModel.id);
    await StoreService().updateProduct(product: productModel);
  }
}
