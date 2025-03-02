import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';
import 'package:my_messaging/controller/controllers.dart';
import 'package:my_messaging/core/widgets/widgets.dart';
import 'package:my_messaging/screens/auth/signup.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const LoginScreen());

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showToast(msg: "Kindly enter email and password both.");
      return;
    }
    ref
        .read(authControllerProvider.notifier)
        .login(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/logo.png", width: 200),
                        const SizedBox(height: 30),
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
                                  onLogin(), // your tap handler moved here
                          builder: (
                            BuildContext context,
                            TapDebouncerFunc? onTap,
                          ) {
                            return FilledButton(
                              onPressed: onTap,
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: FontSize.medium),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: FontSize.medium,
                              color: context.onSurfaceColor,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                  fontSize: FontSize.medium,
                                  color: context.primaryColor,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          SignUpScreen.route(),
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
