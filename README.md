# 🛒 Flutter E-Commerce App

A modern, full-featured e-commerce mobile application built with Flutter and Firebase, offering both customer and admin functionalities.

![App Banner](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/WhatsApp%20Image%202025-08-13%20at%2017.12.37_4d591889.jpg)

## 📱 Demo Video

[![Demo Video](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/login.png)](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_video/XRecorder_Edited_20102024_173448.mp4)

## ✨ Features

### 🛍️ Customer Features
- **User Authentication** - Secure login/signup with Firebase Auth
- **Product Browsing** - Browse products by categories and brands
- **Advanced Search** - Real-time product search functionality
- **Shopping Cart** - Add, remove, and manage cart items
- **Product Details** - Detailed product information with images
- **Order Management** - Place and track orders
- **Profile Management** - Update user profile and preferences
- **Onboarding** - Smooth app introduction for new users

### 👨‍💼 Admin Features
- **Product Management** - Add, edit, and delete products
- **Category Management** - Organize products by categories
- **Order Management** - View and manage customer orders
- **Inventory Control** - Track product quantities and availability
- **Admin Dashboard** - Comprehensive admin panel

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Firestore, Auth, Storage)
- **State Management:** BLoC/Cubit
- **Database:** Cloud Firestore & Realtime Database
- **Authentication:** Firebase Auth
- **Storage:** Firebase Storage
- **Local Storage:** SharedPreferences

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/          # App constants and colors
│   ├── utils/             # Utilities and routing
│   └── widget/            # Reusable widgets
├── cubits/                # State management (BLoC)
├── features/              # Feature-based architecture
│   ├── admin/             # Admin functionality
│   ├── auth/              # Authentication
│   ├── onboarding/        # App onboarding
│   └── splash/            # Splash screen
├── models/                # Data models
├── services/              # API and Firebase services
└── views/                 # Main application views
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.4.4)
- Dart SDK
- Android Studio / VS Code
- Firebase Account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/flutter-ecommerce-app.git
cd flutter-ecommerce-app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication, Firestore, and Storage
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in their respective directories

4. **Configure Firebase**
```bash
flutter packages pub run build_runner build
```

5. **Run the app**
```bash
flutter run
```

## 🔧 Configuration

### Firebase Rules
Configure Firestore security rules for your collections:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /products/{document} {
      allow read, write: if request.auth != null;
    }
    match /users/{document} {
      allow read, write: if request.auth != null;
    }
    match /orders/{document} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 📱 Supported Categories

- 📱 Android Mobiles
- 🍎 iPhone
- 💻 Laptops
- 📱 Tablets
- ⌚ Watches
- 📺 TV
- 🖥️ PC
- 📱 iPad
- 📷 Cameras
- 🎮 PlayStation
- 🔧 Others

## 🏷️ Supported Brands

- Samsung
- Apple
- Xiaomi
- Huawei
- Realme
- Vivo
- Oppo
- Nokia
- Sony
- Lenovo
- HP
- Dell
- Others

## 🎨 UI/UX Features

- **Material Design** - Modern and intuitive interface
- **Smooth Animations** - Enhanced user experience
- **Custom Components** - Reusable UI components

## 🔒 Security Features

- Firebase Authentication
- Secure API endpoints
- Input validation
- Error handling
- User role management (Admin/User)

## 📸 Screenshots

|Login | Home | Product Details | Cart |
|------------|-------|------|-----------------|
| ![Login](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/login.png) | ![Home](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/home.png) | ![Product](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/product.png) | ![Cart](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/card.png) | 

| Admin Panel | Manage Products | Orders |
|------|-------------|------------|
| ![Admin](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/admin.png) | ![Manage Products](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/manage_products.png) | ![Orders](https://raw.githubusercontent.com/Tarek3222/e_commerce-app/refs/heads/main/assets/app_images/orders.png) |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Tarek Ahmed**
- GitHub: [@Tarek3222](https://github.com/Tarek3222)
- LinkedIn: [Trarek Ahmed Belal](https://www.linkedin.com/in/tarek-ahmed-belal-62b238368?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
- Email: tarekahmedbelal@gmail.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Community contributors and package maintainers
- Design inspiration from modern e-commerce apps

## 📞 Support

If you like this project, please consider giving it a ⭐ on GitHub!

For support, email your.email@example.com or create an issue in this repository.

---

**Happy Shopping! 🛍️**
