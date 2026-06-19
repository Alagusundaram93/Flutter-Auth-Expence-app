import 'package:flutter/material.dart';

import '../../../core/utils/shared_pref_helper.dart';

import '../home/home_screen.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    checkLogin();

  }

  Future<void> checkLogin() async {  //check if user is logged in or not

    final token = await SharedPrefHelper.getToken(); //get token from shared preferences
    print("Saved Token => $token");
    await Future.delayed(

      const Duration(seconds: 2),

    );

    if(token != null){ // user login panerukanga so token null illa, return home screen

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => const HomeScreen(),

        ),

      );

    }

    else{

      Navigator.pushReplacement( //user login panala so token null,return login screen

        context,

        MaterialPageRoute(

          builder: (_) => const LoginScreen(),

        ),

      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(

        child: Text(

          "Expense Tracker",

          style: TextStyle(

            fontSize: 28,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    );

  }

}