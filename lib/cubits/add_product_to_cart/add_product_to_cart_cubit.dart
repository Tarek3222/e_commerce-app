import 'package:e_commerce_app/cubits/add_product_to_cart/add_product_to_cart_states.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/products_in_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductToCartCubit extends Cubit<States> {
  AddProductToCartCubit() : super(InatialState());
  List<ProductModel> products = [];
  addProductToCart(ProductModel product) async {
    await ProductsInCart().addProductInCart(product);
    emit(SuccessState());
  }
  editProductFormCart(ProductModel product) async {
    await ProductsInCart().editProductFormCart(product);
    await loadProducts();
    emit(SuccessState());
  }

  loadProducts() async {
    products = await ProductsInCart().getProductsInCart();
    emit(SuccessState());
  }

  removeProductFromCart(ProductModel product) async {
    try {
      products.remove(product);
      await ProductsInCart().removeProductFromCart(product);
      emit(SuccessState());
    } catch (e) {
      products.add(product);
    }
  }

  clearCart() {
    products.clear();
    emit(SuccessState());
  }
}
