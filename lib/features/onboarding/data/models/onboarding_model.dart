
class OnBoardModel {
  final String image;
  final String title;
  final String subTitle;
  OnBoardModel(
      {required this.image, required this.title, required this.subTitle});

  static List<OnBoardModel> onBoardList = [
    OnBoardModel(
        image: 'assets/images/onboard3.jpg',
        title: "Online Shopping from mobile",
        subTitle:
            "Get the best online shopping experience with our mobile application, which allows you to shop from anywhere and anytime."),
    OnBoardModel(
        image: 'assets/images/onboard2.jpg',
        title: "Utility Cart for your needs",
        subTitle:
            "Add products to your cart, make payments and get your order delivered to your doorsteps."),
  ];
}
