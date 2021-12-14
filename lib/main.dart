import 'package:flutter/material.dart';

import 'package:filmsapp/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:filmsapp/providers/movies_provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'details': (_) => const DetailsPage()
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.cyan)),
    );
  }
}
