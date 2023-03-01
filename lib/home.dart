import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_overflow/auth_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(child: Consumer<User?>(builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model?.displayName ?? 'Default'),
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text(model == null ? 'Login' : 'Logout'),
              onPressed: () async {
                if (model == null) {
                  await AuthHelper.googleSignIn();
                } else {
                  await AuthHelper.googleSignout();
                }
                // log(Provider.of<User?>(context)?.displayName.toString() ?? '');
              },
            ),
            Visibility(
              visible: model != null,
              child: ElevatedButton(
                child: const Text('Clean up provider by code'),
                onPressed: () async {
                  AuthHelper.clearUserProgrammatically();
                },
              ),
            ),
          ],
        );
      })),
    );
  }
}
