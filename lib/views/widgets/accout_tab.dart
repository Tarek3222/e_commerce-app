// ignore_for_file: use_build_context_synchronously
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/views/log_in_view.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/services/cloud_user_service.dart';
import 'package:e_commerce_app/views/get_help_view.dart';
import 'package:e_commerce_app/views/profile_user_view.dart';
import 'package:e_commerce_app/views/widgets/custom_list_tile.dart';
import 'package:e_commerce_app/views/widgets/info_of_user.dart';
import 'package:e_commerce_app/views/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
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
              users.add(
                UserModel(
                  name: doc.get(kName),
                  email: doc.get(kEmail),
                  password: doc.get(kPassword),
                  phone: doc.get(kPhone),
                  id: doc.id,
                  image: doc.get(kImage),
                ),
              );
            }
          }
          var all = users.where((element) => element.email == email).toList();
          var userModel = all[0];
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(
                    text: "Account",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoOfUser(user: userModel),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomListTile(
                    iconLeading: Icons.account_circle,
                    text: 'Profile',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProfileUserView(
                            user: userModel,
                          );
                        },
                      ));
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomListTile(
                    iconLeading: Icons.support_agent,
                    text: 'Get Help',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const GetHelpView();
                        },
                      ));
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomListTile(
                    iconLeading: Icons.logout,
                    text: 'Logout',
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool(kKeepMeLoggedIn, false);
                      await AuthService().signOut();
                      Navigator.pushReplacementNamed(
                          context, LogInView.loginVeiwId);
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
