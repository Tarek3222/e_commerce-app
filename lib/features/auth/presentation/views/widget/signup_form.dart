import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:e_commerce_app/core/widget/custom_text_form_field.dart';
import 'package:e_commerce_app/services/cloud_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password, name, phone;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your name',
              label: 'Name',
              inputType: TextInputType.name,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your name';
                }
                return null;
              },
              onChanged: (data) {
                name = data;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your phone number',
              label: 'phone number',
              inputType: TextInputType.name,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                  color: AppColors.myGrey,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onChanged: (data) {
                phone = data;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your email',
              label: 'Email',
              inputType: TextInputType.emailAddress,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email,
                  color: AppColors.myGrey,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email';
                }
                return null;
              },
              onChanged: (data) {
                email = data;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              colorTheme: AppColors.myGrey,
              hintText: 'Enter your Password',
              label: 'Password',
              inputType: TextInputType.visiblePassword,
              obscureText: isObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.myGrey,
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                }
                return null;
              },
              onChanged: (data) {
                password = data;
              },
            ),
            const SizedBox(
              height: 60,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: AppColors.myGrey,
                  ))
                : CustomButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      await signup(context);
                    }),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: AppColors.kPrimaryColor),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signup(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final credential = await AuthService()
            .signUp(email: email!.trim(), password: password!.trim());
        if (credential.user != null) {
          await addUser();
        }
        showSnackBar(context, 'Account created successfully', Colors.green);

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.message.toString(), Colors.red);
      } catch (e) {
        showSnackBar(context, e.toString(), Colors.red);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> addUser() async {
    final user = UserModel(
      name: name ?? 'unknown',
      email: email ?? 'unknown',
      password: password ?? 'unknown',
      phone: phone ?? 'unknown',
    );
    await CloudStoreUsers().addUser(user: user);
  }
}
