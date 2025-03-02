import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';
import 'package:my_messaging/core/widgets/widgets.dart';
import 'package:my_messaging/controller/auth_controller.dart';
import 'package:my_messaging/screens/auth/login.dart';
import 'package:my_messaging/screens/home.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Messaging App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: MyInitialPage(),
      ),
    );
  }
}

class MyInitialPage extends ConsumerWidget {
  const MyInitialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getcurrentUser = ref.watch(currentUserAccountProvider);
    return getcurrentUser.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
      error: (error, stackTrace) => LoginScreen(),
      loading: () => showSplashScreen(context),
    );
  }
}
