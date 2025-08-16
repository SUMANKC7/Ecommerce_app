import 'package:ecommerce_application/authentication/loginpage.dart';
import 'package:ecommerce_application/authentication/signup.dart';
import 'package:ecommerce_application/features/map.dart';
import 'package:ecommerce_application/firebase_options.dart';
import 'package:ecommerce_application/pages/addtocart.dart';
import 'package:ecommerce_application/pages/frontpage.dart';
import 'package:ecommerce_application/pages/home.dart';
import 'package:ecommerce_application/pages/homepage.dart';
import 'package:ecommerce_application/provider/bottom_nav.dart';
import 'package:ecommerce_application/provider/buynow_provider.dart';
import 'package:ecommerce_application/provider/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load env file FIRST
  await dotenv.load(fileName: ".env");

  // Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Assign publishable key from env
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BuyNowProvider(0.0)),
      ],
      child: const ElectronicCommerce(),
    ),
  );
}

class ElectronicCommerce extends StatelessWidget {
  const ElectronicCommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "E-Commerce App",
        initialRoute: "frontpage",
        routes: {
          "loginpage": (context) => const Loginpage(),
          "signuppage": (context) => const SignUppage(),
          "homepage": (context) => const Homepage(),
          "home": (context) => Homescreen(categories: []),
          "map": (context) => MapPage(),
          "cartpage": (context) => CartPage(),
          "frontpage": (context) => Frontpage(),
        },
      ),
    );
  }
}
