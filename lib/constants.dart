import 'package:flutter/material.dart';

 const kPrimaryColor=Color(0xFF767676);
 const String kCollectionProducts = 'products';
 const String kProductName = 'productName';
 const String kProductCategory = 'productCategory';
 const String kProductPrice = 'productPrice';
 const String kProductDescription = 'productDescription';
 const String kProductLocation = 'productLocation';
 const String kProductQuantity = 'productQuantity';
 const String kProductId='id';
 const String kUserId = 'userId';
 const String kUserRealDpId='UserRealId';
 const String kOrder='orders';
 const String kOrderDetails='orderDetails';
 const String kTotalPrice='totalPrice';
 const String kAddress='address';
 const String kQuantityInCart='quantityInCart';
 void showSnackBar(BuildContext context,String text,Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text,style: const TextStyle(color: Colors.white),),
    backgroundColor:backgroundColor ,
    showCloseIcon: true,
  ));
}

const String kJacketsCategory = 'jackets';
const String kTrousersCategory = 'trousers';
const String kElectronicsCategory = 'electronics';
const String kShoesCategory = 'shoes';
const String kAccessoriesCategory = 'accessories';
const String kWatchesCategory = 'watches';
const String kBagsCategory = 'bags';
const String kGlassesCategory = 'glasses';
const String kTShirtsCategory = 'T-shirts';
const String kOthersCategory = 'others';
const List<String> kCategories = [
  kJacketsCategory,
  kTrousersCategory,
  kElectronicsCategory,
  kShoesCategory,
  kAccessoriesCategory,
  kWatchesCategory,
  kBagsCategory,
  kGlassesCategory,
  kTShirtsCategory,
  kOthersCategory
];

const String kKeepMeLoggedIn = 'keepMeLoggedIn';
const String kAdmin='admin';
const String kUser='user';