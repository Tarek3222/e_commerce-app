import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:e_commerce_app/features/auth/presentation/views/widget/remember_me_widget.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/features/admin/presentation/views/admin_home_view.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/core/widget/custom_button.dart';
import 'package:e_commerce_app/core/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;
  bool isLoading = false;
  String passwordAdmin = 'admin1234';
  String emailAdmin = 'admin@gmail.com';
  bool keepMeLoggedIn = false;
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
            const SizedBox(
              height: 10,
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
              height: 10,
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
              height: 30,
            ),
            RememberMeWidget(
              keepMeLoggedIn: keepMeLoggedIn,
              onChanged: (value) {
                setState(() {
                  keepMeLoggedIn = value!;
                });
              },
            ),
            const SizedBox(
              height: 5,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      if (keepMeLoggedIn == true) {
                        keepUserLogedIn();
                      }
                      await validateUser(context);
                    }),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: kPrimaryColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpView.signUpViewId);
                    formKey.currentState?.reset();
                    autovalidateMode = AutovalidateMode.disabled;
                    keepMeLoggedIn = false;
                  },
                  child: const Text(
                    'SignUp',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validateUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final user = await AuthService()
            .signIn(email: email!.trim(), password: password!.trim());

        if (email == emailAdmin && password == passwordAdmin) {
          Navigator.pushReplacementNamed(context, AdminHomeView.id);
        } else {
          Navigator.pushReplacementNamed(context, HomeView.homeViewId);
        }
      } on FirebaseAuthException catch (e) {
        showSnackBar(
          context,
          e.message.toString(),
          Colors.red,
        );
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

  keepUserLogedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
