import 'package:flutter/material.dart';
// import 'package:flutter_accessibility/presentation/counter_page.dart';
import 'package:flutter_accessibility/presentation/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Accessibility',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      home: const HomePage(title: 'Flutter Acessibility Demo'),
    );
  }
}
