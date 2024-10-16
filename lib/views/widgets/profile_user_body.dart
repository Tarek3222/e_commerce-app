import 'dart:io';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/services/cloud_user_service.dart';
import 'package:e_commerce_app/views/widgets/custom_account_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUserBody extends StatefulWidget {
  const ProfileUserBody({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileUserBody> createState() => _ProfileUserBodyState();
}

class _ProfileUserBodyState extends State<ProfileUserBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Stack(
            children: [
              widget.user.image.isNotEmpty
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: Image.network(widget.user.image).image,
                    )
                  : const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person),
                    ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: InkWell(
                    onTap: () async {
                      final file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file == null) return;
                      String fileName =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      // Create a reference to the location you want to upload to in Firebase Storage
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');
                      // Create a Reference to the file you want to upload
                      Reference referenceImageToUpload =
                          referenceDirImages.child(fileName);
                      // Upload the file to firebase
                      try {
                        await referenceImageToUpload.putFile(File(file.path));
                        widget.user.image =
                            await referenceImageToUpload.getDownloadURL();
                        CloudStoreUsers().updateUser(user: widget.user);
                        setState(() {});
                        showSnackBar(context, 'Image Updated', Colors.green);
                      } catch (e) {
                        showSnackBar(context, e.toString(), Colors.red);
                      }
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
            thickness: 0.2,
          ),
          const SizedBox(
            height: 25,
          ),
          CustomAccountInfo(data: widget.user.name, icon: Icons.person),
          const SizedBox(
            height: 20,
          ),
          CustomAccountInfo(data: widget.user.email, icon: Icons.email),
          const SizedBox(
            height: 20,
          ),
          CustomAccountInfo(
              data: widget.user.phone, icon: Icons.phone_android_outlined),
        ],
      ),
    );
  }
}
