import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/auth_screen.dart';
import 'package:yoga_app/theme_provider.dart';
import 'services/firebase_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD9G0QI2CZBebre-MLB7HMA2Lf7C_0_oQ4',
      appId: '1:370617044450:android:8971d2e13e5de4f416fdbb',
      messagingSenderId: '370617044450',
      projectId: "yogaapp-199e5",
    ),
  );

  // Initialiser les données
  final firebaseService = FirebaseService();
  await firebaseService.initializeData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<FirebaseService>.value(value: firebaseService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Yoga App',
          theme: themeProvider.themeData,
          home: const AuthScreen(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'),
        );
      },
    );
  }
}
