import 'package:adidas/providers/admin_provider.dart';
import 'package:adidas/providers/auth_provider.dart';
import 'package:adidas/providers/cart_provider.dart';
import 'package:adidas/providers/main_screen_provider.dart';
import 'package:adidas/providers/payment_provider.dart';
import 'package:adidas/providers/profile_provider.dart';
import 'package:adidas/providers/signin_provider.dart';
import 'package:adidas/providers/signup_provider.dart';
import 'package:adidas/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SignInProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MainScreenProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AdminProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ), 
      ChangeNotifierProvider(
        create: (context) => PaymentProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
