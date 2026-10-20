import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/supabase/supabase_client.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'views/auth/login_view.dart';
import 'views/chat_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = SupabaseService.client.auth.currentSession;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Supabase Chat',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: session != null ? const ChatListView() : const LoginView(),
      ),
    );
  }
}