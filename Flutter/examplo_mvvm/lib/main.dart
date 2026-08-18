import 'package:examplo_mvvm/ui/view/home.dart';
import 'package:examplo_mvvm/ui/view/loginPage.dart';
import 'package:examplo_mvvm/ui/view/registerUserPage.dart';
import 'package:examplo_mvvm/ui/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child:MaterialApp(
        title: 'MVVM Appss',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterView(),
        }
    )
    );
  }
}
