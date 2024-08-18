class ProductModel {
   String name;
   String description;
   String imageLocation;
   String price;
   String category;
   String quantity;
  final String? id;
  int? quantityInCart;
  String? userId;
  String?productAvilable = 'yes';
  String? productIdReal;//id of the product in the real database

  ProductModel( 
      {required this.name,
      this.id,
      this.userId,
      this.productAvilable,
      this.productIdReal,
      this.quantityInCart,
      required this.description,
      required this.imageLocation,
      required this.price,
      required this.category,
      required this.quantity});
}
