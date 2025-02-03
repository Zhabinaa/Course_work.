import 'package:flutter/material.dart';
import 'package:flutter_application_2/account_page.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:flutter_application_2/auth_page.dart';
import 'package:flutter_application_2/cart/cart.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/izb.dart';
import 'package:flutter_application_2/korzina.dart';
import 'package:flutter_application_2/login_page.dart';
import 'package:flutter_application_2/reg_page.dart';
import 'package:flutter_application_2/whaitlist/whaitlist.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dvpuueplcxcucgehjwtb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2cHV1ZXBsY3hjdWNnZWhqd3RiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4ODI5MDEsImV4cCI6MjA1MzQ1ODkwMX0.ymBtgF4Z5DrMznVHESy-1uNhMMp-aweHUdAA33JgGwE',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final passCheck = UserData();
    final cart = Cart();
    final whaitlist = Whaitlist();

    passCheck.userCheck();
    if (passCheck.user != null) {
      passCheck.getUserData();
      passCheck.getCart();
      passCheck.getWhaitlist();
      passCheck.loadAdresses();
      passCheck.loadCards();
      passCheck.fetchOrderHistory(passCheck.user!.id.toString());
    }

    final GoRouter routes = GoRouter(initialLocation: '/', routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(
          userData: passCheck,
          cart: cart,
          whaitlist: whaitlist,
        ),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => AuthPage(
          userData: passCheck,
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(
          userData: passCheck,
        ),
      ),
      GoRoute(
        path: '/regist',
        builder: (context, state) => RegPage(
          userData: passCheck,
        ),
      ),
      GoRoute(
        path: '/user_page',
        builder: (context, state) => AccountPage(
          userData: passCheck,
        ),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => CartScreen(
          userData: passCheck,
          cart: cart,
        ),
      ),
      GoRoute(
        path: '/whaitlist',
        builder: (context, state) => FavoritesScreen(
          userData: passCheck,
          whaitlist: whaitlist,
        ),
      ),
    ]);
    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
