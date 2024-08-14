import 'dart:io';

import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:e_commerce_app/views/widgets/custom_text_form_field.dart';
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
      productImageLocation,
      productPrice,
      productQuantity;
  String productCategory = kCategories[0];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomTextFormField(
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
            height: 15,
          ),
          CustomTextFormField(
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
            height: 15,
          ),
          CustomTextFormField(
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
            height: 15,
          ),
          CustomTextFormField(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Category : ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButtonFormField(
                    iconEnabledColor: Colors.black,
                    value: productCategory,
                    items: [
                      for (final category in kCategories)
                        DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(color: Colors.grey),
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
          Row(
            children: [
              const Text(
                'Image: ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 80,
              ),
              IconButton(
                onPressed: ()async {
                  final file=await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(file==null) return;
                  String fileName=DateTime.now().microsecondsSinceEpoch.toString();
                  // Get a reference to storage root
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImages=referenceRoot.child('images');
                  // We have to create reference to image to put in storage
                  Reference referenceImageToUpload=referenceDirImages.child(fileName);
                  //for Errors handling 
                  try{
                    await referenceImageToUpload.putFile(File(file.path));
                    productImageLocation=await referenceImageToUpload.getDownloadURL();
                    Fluttertoast.showToast(msg: 'Image uploaded successfully');
                  }catch(e){
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                  size: 26,
                ),
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
                  if(productImageLocation==null){
                    Fluttertoast.showToast(msg: 'Please add product image');
                    return;
                  }
                  addProduct();
                  formKey.currentState!.reset();
                  productImageLocation=null;
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
      name: productName!,
      price: productPrice!,
      description: productDescription!,
      category: productCategory,
      quantity: productQuantity!,
      imageLocation: productImageLocation!,
    );
    StoreService().addProduct(product: productModel);
    Fluttertoast.showToast(
      msg: 'Product added successfully',
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
