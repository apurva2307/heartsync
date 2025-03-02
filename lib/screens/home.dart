import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';
import 'package:my_messaging/controller/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void onLogout() {
    ref.read(authControllerProvider.notifier).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.black,
          height: 30,
          width: 30,
          child: Image.asset("assets/onlyLogo.png", height: 30),
        ),
        centerTitle: true,
      ), // appbar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(Spacing.medium),
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: onLogout,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("HOme screen"), Text("hi")],
        ),
      ),
    );
  }
}
