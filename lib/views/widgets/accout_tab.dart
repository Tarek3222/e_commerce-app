// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/views/log_in_view.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/services/cloud_user_service.dart';
import 'package:e_commerce_app/views/widgets/custom_account_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  String updateImage = '';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'unknown';
    return StreamBuilder(
        stream: CloudStoreUsers().getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserModel> users = [];
            for (var doc in snapshot.data!.docs) {
              if (doc.get(kEmail) == email) {
                users.add(UserModel(
                  name: doc.get(kName),
                  email: doc.get(kEmail),
                  password: doc.get(kPassword),
                  phone: doc.get(kPhone),
                  id: doc.id,
                  image: doc.get(kImage),
                ));
              }
            }
            var all = users.where((element) => element.email == email).toList();
            var userModel = all[0];
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file == null) return;
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        // Create a reference to the location you want to upload to in Firebase Storage
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
                        // Create a Reference to the file you want to upload
                        Reference referenceImageToUpload =
                            referenceDirImages.child(fileName);
                        // Upload the file to firebase
                        try {
                          await referenceImageToUpload.putFile(File(file.path));
                          updateImage =
                              await referenceImageToUpload.getDownloadURL();
                          userModel.image = updateImage;
                          CloudStoreUsers().updateUser(user: userModel);
                          setState(() {});
                          showSnackBar(context, 'Image Updated',
                              AppColors.kPrimaryColor);
                        } catch (e) {
                          showSnackBar(context, e.toString(), Colors.red);
                        }
                      },
                      child: userModel.image != ''
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: Image.network(
                                userModel.image,
                              ).image)
                          : const Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.kPrimaryColor,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.myWhite,
                                    size: 60,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.myWhite,
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.myGrey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomAccountInfo(
                      icon: Icons.person,
                      data: userModel.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomAccountInfo(
                      icon: Icons.phone,
                      data: userModel.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomAccountInfo(
                      icon: Icons.email,
                      data: userModel.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool(kKeepMeLoggedIn, false);
                        await AuthService().signOut();
                        Navigator.pushReplacementNamed(
                            context, LogInView.loginVeiwId);
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
