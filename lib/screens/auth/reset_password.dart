import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';
import 'package:my_messaging/controller/controllers.dart';
import 'package:my_messaging/core/widgets/widgets.dart';
import 'package:my_messaging/screens/auth/login.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen());

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  void onResetPassword() {
    if (emailController.text.isEmpty) {
      showToast(msg: "Kindly enter email.");
      return;
    }
    ref
        .read(authControllerProvider.notifier)
        .resetPassword(email: emailController.text, context: context);
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
                        const SizedBox(height: 30),
                        TapDebouncer(
                          cooldown: const Duration(milliseconds: 2000),
                          onTap:
                              () async =>
                                  onResetPassword(), // your tap handler moved here
                          builder: (
                            BuildContext context,
                            TapDebouncerFunc? onTap,
                          ) {
                            return FilledButton(
                              onPressed: onTap,
                              child: const Text(
                                "Send Reset Password Link",
                                style: TextStyle(fontSize: FontSize.medium),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            text: "Already Have Password? ",
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
