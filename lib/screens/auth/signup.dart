import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';
import 'package:my_messaging/controller/controllers.dart';
import 'package:my_messaging/core/widgets/widgets.dart';
import 'package:my_messaging/screens/auth/login.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void onSignup() {
    if (nameController.text.isEmpty) {
      showToast(msg: "Kindly enter your name.");
      return;
    }
    if (emailController.text.isEmpty) {
      showToast(msg: "Kindly enter your email.");
      return;
    }
    if (passwordController.text.isEmpty) {
      showToast(msg: "Kindly enter your password.");
      return;
    }
    ref
        .read(authControllerProvider.notifier)
        .signUp(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body:
          isLoading
              ? MyLoader()
              : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/logo.png", width: 200),
                        const SizedBox(height: 30),
                        AuthField(
                          controller: nameController,
                          hintText: "Enter name",
                        ),
                        const SizedBox(height: 20),
                        AuthField(
                          controller: emailController,
                          hintText: "Enter email",
                        ),
                        const SizedBox(height: 20),
                        AuthField(
                          controller: passwordController,
                          hintText: "Enter password",
                          isPassword: true,
                        ),
                        const SizedBox(height: 30),
                        TapDebouncer(
                          cooldown: const Duration(milliseconds: 2000),
                          onTap:
                              () async =>
                                  onSignup(), // your tap handler moved here
                          builder: (
                            BuildContext context,
                            TapDebouncerFunc? onTap,
                          ) {
                            return FilledButton(
                              onPressed: onTap,
                              child: const Text(
                                "SignUp",
                                style: TextStyle(fontSize: FontSize.medium),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(
                              fontSize: FontSize.medium,
                              color: context.onSurfaceColor,
                            ),
                            children: [
                              TextSpan(
                                text: ' Login',
                                style: TextStyle(
                                  fontSize: FontSize.medium,
                                  color: context.primaryColor,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          LoginScreen.route(),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
