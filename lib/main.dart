import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc_class/drink_bloc.dart';
import 'package:test_task/event/drink_event.dart';
import 'package:test_task/mainfolders/my_collection.dart';
import 'package:test_task/mainfolders/splash_screen.dart';
import 'package:test_task/repository/drinks_repository.dart';


void main() {
  final drinkRepository = DrinkRepository();  // Create an instance of DrinkRepository

  runApp(
    RepositoryProvider<DrinkRepository>(
      create: (_) => drinkRepository,  // Provide the repository
      child: BlocProvider(
        create: (context) => DrinkBloc(drinkRepository)..add(LoadDrinks()),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

