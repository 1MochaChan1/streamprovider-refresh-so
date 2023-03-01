import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_overflow/auth_helper.dart';
import 'package:stack_overflow/firebase_options.dart';
import 'package:stack_overflow/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (_) => AuthHelper.currUserController.stream,
            // create: (_) => FirebaseAuth.instance.authStateChanges(),
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        // home: Provider.of<User?>(context)?.displayName != null
        //     ? const HomePage()
        //     : const LoginPage()
      ),
    );
  }
}
