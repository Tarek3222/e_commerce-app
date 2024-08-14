import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:e_commerce_app/views/admin_home_view.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/views/sign_up_user_or_admin.dart';
import 'package:e_commerce_app/views/widgets/custom_button.dart';
import 'package:e_commerce_app/views/widgets/custom_text_form_field.dart';
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
  String selectedState = 'User';
  final String adminPassword = 'admin1234';
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
            CustomTextFormField(
              hintText: 'Enter your email',
              label: 'Email',
              inputType: TextInputType.emailAddress,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email,
                  color: kPrimaryColor,
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
                  color: kPrimaryColor,
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
            Row(
              children: [
                Checkbox(
                  value: keepMeLoggedIn,
                  activeColor: kPrimaryColor,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      keepMeLoggedIn = value!;
                    });
                  },
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'You are',
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text(
                'User',
                style: TextStyle(color: kPrimaryColor),
              ),
              leading: Radio<String>(
                value: 'User',
                groupValue: selectedState,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Admin',
                style: TextStyle(color: kPrimaryColor),
              ),
              leading: Radio<String>(
                value: 'Admin',
                groupValue: selectedState,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                  });
                },
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      if (keepMeLoggedIn == true) {
                        keepUserLogedIn();
                      }
                      await validateUser(context);
                    }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: kPrimaryColor),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpUserOrAdmin.id);
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Colors.black),
                    ))
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

        if (selectedState == 'Admin') {
          if (password == adminPassword) {
            // ignore: unused_local_variable
            final user =
                await AuthService().signIn(email: email!, password: password!);
            Navigator.pushReplacementNamed(
                // ignore: use_build_context_synchronously
                context,
                AdminHomeView.id);
          } else {
            // ignore: use_build_context_synchronously
            showSnackBar(context, 'something went wrong', Colors.red);
          }
        } else {
          // ignore: unused_local_variable
          final user = await AuthService()
              .signIn(email: email!.trim(), password: password!.trim());
          Navigator.pushReplacementNamed(
              // ignore: use_build_context_synchronously
              context,
              HomeView.homeViewId,arguments: email!);
        }
      } on FirebaseAuthException catch (e) {
        showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          e.message.toString(),
          Colors.red,
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
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
