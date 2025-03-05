import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/api/auth_api.dart';
import 'package:my_messaging/api/user_api.dart';
import 'package:my_messaging/core/widgets/widgets.dart';
import 'package:my_messaging/models/models.dart';
import 'package:my_messaging/screens/auth/login.dart';
import 'package:my_messaging/screens/home.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
    : _authAPI = authAPI,
      _userAPI = userAPI,
      super(false);
  // state = isLoading

  Future<User?> currentUser() => _authAPI.currentUser();

  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      name: name,
      email: email,
      password: password,
    );
    state = false;
    res.fold((l) => showToast(msg: l.message), (r) async {
      UserModel userModel = UserModel(
        email: email,
        name: name,
        followers: const [],
        following: const [],
        profilePic: '',
        bannerPic: '',
        uid: r.$id,
        bio: '',
        isVerified: false,
        partners: [r.$id],
      );
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showToast(msg: l.message), (r) {
        showToast(msg: 'Accounted created! Please login.', type: 'Success');
        Navigator.push(context, LoginScreen.route());
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);

    res.fold(
      (l) {
        state = false;
        showToast(msg: l.message, type: "Error");
      },
      (r) async {
        final user = await _authAPI.currentUser();
        state = false;
        if (user == null) {
          // ignore: use_build_context_synchronously
          Navigator.push(context, LoginScreen.route());
          return;
        } else {
          if (!user.emailVerification) {
            _authAPI.sendEmailVerification();
            _authAPI.logout();
            showToast(
              msg:
                  "Your email is not verified. Kindly chech your email to verify.",
              type: "Error",
            );
            return;
          } else {
            Navigator.pushAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              HomeScreen.route(),
              (route) => false,
            );
          }
        }
      },
    );
  }

  void resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.resetPassword(email: email);
    state = false;
    res.fold((l) => showToast(msg: l.message, type: "Error"), (r) {
      showToast(
        msg: "Reset Password link sent to your email. Lindly check!",
        type: "Success",
      );
      Navigator.push(context, LoginScreen.route());
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
        context,
        LoginScreen.route(),
        (route) => false,
      );
    });
  }
}
