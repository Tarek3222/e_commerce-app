import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/orders_model.dart';
import 'package:e_commerce_app/models/product_model.dart';

class StoreService {
  CollectionReference products =
      FirebaseFirestore.instance.collection(kCollectionProducts);

  Future<void> addProduct({required ProductModel product}) {
    return products.add({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDescription: product.description,
      kProductCategory: product.category,
      kProductQuantity: product.quantity,
      kProductLocation: product.imageLocation,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return products.snapshots();
  }

  Future<void> deleteProduct({required String id}) async {
    return await products.doc(id).delete();
  }

  Future<void> updateProduct({required ProductModel product}) async {
    return await products.doc(product.id).update({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDescription: product.description,
      kProductCategory: product.category,
      kProductQuantity: product.quantity,
      kProductLocation: product.imageLocation,
      kUserRealDpId: product.productIdReal ?? "",
    });
  }

  storeOrders(data, List<ProductModel> products) {
    var documentReference = FirebaseFirestore.instance.collection(kOrder).doc();
    documentReference.set(data);
    for (var product in products) {
      documentReference.collection(kOrderDetails).doc().set({
        kProductName: product.name,
        kProductPrice: product.price,
        kQuantityInCart: product.quantityInCart,
        kProductLocation: product.imageLocation,
        kProductCategory: product.category,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return FirebaseFirestore.instance.collection(kOrder).snapshots();
  }

  cancelOrder(OrdersModel order) async {
    return await FirebaseFirestore.instance
        .collection(kOrder)
        .doc(order.id)
        .delete();
  }

  Future<void> updateOrder({required OrdersModel order}) async {
    return await FirebaseFirestore.instance
        .collection(kOrder)
        .doc(order.id)
        .update({
      kTotalPrice: order.totalPrice,
      kAddress: order.address,
      'Status': order.statusOrder??"Confirmed",
    });
  }

  Stream<QuerySnapshot> loadOrdersDetails(String id) {
    return FirebaseFirestore.instance
        .collection(kOrder)
        .doc(id)
        .collection(kOrderDetails)
        .snapshots();
  }
}
