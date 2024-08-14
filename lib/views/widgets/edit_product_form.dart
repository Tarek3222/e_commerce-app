import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store_service.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:e_commerce_app/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  String? productName,
      productDescription,
      productImageLocation,
      productPrice,
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
            height: 50,
          ),
          CustomTextFormField(
            hintText: widget.productModel.name,
            onChanged: (data) {
              productName = data;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
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
            inputType: TextInputType.number,
            hintText: widget.productModel.quantity,
            onChanged: (data) {
              productQuantity = data;
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
                    value: widget.productModel.category,
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
                    fontSize: 16.0
                  );
                } 
              },
            ),
          )
        ],
      ),
    );
  }
  update() async{
    ProductModel productModel = ProductModel(
      name: productName ??widget.productModel.name,
      price: productPrice ??widget.productModel.price,
      description: productDescription ??widget.productModel.description,
      category: productCategory ,
      quantity: productQuantity ??widget.productModel.quantity,
      imageLocation: productImageLocation ??widget.productModel.imageLocation,
      id: widget.productModel.id
    );
   await StoreService().updateProduct(product: productModel);
  }
}
