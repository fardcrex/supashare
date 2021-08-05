import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supashare/pages/account_page.dart';
import 'package:supashare/pages/login_page.dart';
import 'package:supashare/pages/splash_page.dart';
import 'package:supashare/utils/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase.initialize(
    localStorage: localStorage,
    url: urlSupabase,
    debug: true,
    anonKey: anonKey,
    authCallbackUrlHostname: 'login-callback',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SupaShare',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
      },
    );
  }
}
