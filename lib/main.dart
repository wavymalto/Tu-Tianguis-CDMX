import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plataformav1/config/theme/theme_provider.dart';
import 'package:plataformav1/screens/HomePage/HomePage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

/// a.k.a my fukin proyecto by wavymalto!!!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(),
            themeMode: provider.themeMode,
            title: 'Tianguis CDMX',
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
