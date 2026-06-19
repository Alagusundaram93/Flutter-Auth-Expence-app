import 'package:expense_tracking/data/repositories/expense_repository.dart';
import 'package:expense_tracking/data/services/expense_api_service.dart';
import 'package:expense_tracking/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/auth_repository.dart';
import 'data/services/auth_api_service.dart';

import 'presentation/blocs/auth_bloc/auth_bloc.dart';

import 'presentation/screens/splash/splash_screen.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(

 providers: [

   BlocProvider(

     create: (_) => AuthBloc(

       AuthRepository(

         AuthApiService(),

       ),

     ),

   ),

   BlocProvider(

     create: (_) => ExpenseBloc(

       ExpenseRepository(

         ExpenseApiService(),

       ),

     ),

   ),

 ],

 child: MaterialApp(

   debugShowCheckedModeBanner: false,

   home: const SplashScreen(),

 ),

);
  }
}