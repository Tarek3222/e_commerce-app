import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF767676);
const String kCollectionProducts = 'products';
const String kProductName = 'productName';
const String kProductCategory = 'productCategory';
const String kProductBrand = 'productBrand';
const String kProductPrice = 'productPrice';
const String kProductDescription = 'productDescription';
const String kProductLocation = 'productLocation';
const String kProductQuantity = 'productQuantity';
const String kProductId = 'id';
const String kUserId = 'userId';
const String kUserRealDpId = 'UserRealId';
const String kOrder = 'orders';
const String kOrderDetails = 'orderDetails';
const String kTotalPrice = 'totalPrice';
const String kAddress = 'address';
const String kQuantityInCart = 'quantityInCart';

const String users = 'users';
const String kName = 'name';
const String kEmail = 'email';
const String kPassword = 'password';
const String kImage = 'image';
const String kPhone = 'phone';
void showSnackBar(BuildContext context, String text, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: backgroundColor,
    showCloseIcon: true,
  ));
}

const String kAndroidMobileCategory = 'Android Mobiles';
const String kIphoneCategory = 'Iphone';
const String kLabtopsCategory = 'Laptops';
const String kTabletsCategory = 'Tablets';
const String kWatchesCategory = 'watches';
const String kTvCategory = 'Tv';
const String kPcCategory = 'pc';
const String kIpadCategory = 'ipad';
const String kCamerasCategory = 'Cameras';
const String kPlayStationCategory = 'PlayStation';
const String kOthersCategory = 'others';

const List<String> kCategories = [
  kAndroidMobileCategory,
  kIphoneCategory,
  kLabtopsCategory,
  kTabletsCategory,
  kWatchesCategory,
  kTvCategory,
  kPcCategory,
  kIpadCategory,
  kCamerasCategory,
  kPlayStationCategory,
  kOthersCategory
];

const String kSamsungBrand = 'samsung';
const String kAppleBrand = 'apple';
const String kXiaomiBrand = 'xiaomi';
const String kHuaweiBrand = 'huawei';
const String kRealmeBrand = 'realme';
const String kVivoBrand = 'vivo';
const String kOppoBrand = 'oppo';
const String kNokiaBrand = 'nokia';
const String kSonyBrand = 'sony';
const String kLenovoBrand = 'lenovo';
const String kHpBrand = 'hp';
const String kDellBrand = 'dell';
const String kOthersBrand = 'others';

const List<String> kBrands = [
  kSamsungBrand,
  kAppleBrand,
  kXiaomiBrand,
  kHuaweiBrand,
  kRealmeBrand,
  kVivoBrand,
  kOppoBrand,
  kNokiaBrand,
  kSonyBrand,
  kLenovoBrand,
  kHpBrand,
  kDellBrand,
  kOthersBrand
];

const String kKeepMeLoggedIn = 'keepMeLoggedIn';
const String kAdmin = 'admin';
const String kUser = 'user';
