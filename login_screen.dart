import 'package:expense_tracking/core/utils/shared_pref_helper.dart';
import 'package:expense_tracking/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:expense_tracking/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:expense_tracking/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:expense_tracking/presentation/screens/home/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup/signup_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(

      listener: (context, state) async {

        if (state is AuthSuccess) {
           print("TOKEN => ${state.user.token}");
          await SharedPrefHelper.saveToken(
            state.user.token,
          );
            
             final token = await SharedPrefHelper.getToken();
              print("Saved Token => $token");


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );

        }

        if (state is AuthFailure) {

          ScaffoldMessenger.of(context).showSnackBar(

            SnackBar(

              content: Text(state.message),

            ),

          );

        }

      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        
        body: Padding(

          padding: const EdgeInsets.all(20),

          child: Form(

            key: formKey,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                CustomTextField(

                  controller: emailController,

                  hintText: "Enter Email",

                ),

                const SizedBox(height: 20),

                CustomTextField(

                  controller: passwordController,

                  hintText: "Enter Password",

                  obscureText: true,

                ),

                const SizedBox(height: 30),

                BlocBuilder<AuthBloc, AuthState>(

                  builder: (context, state) {

                    if (state is AuthLoading) {

                      return const CircularProgressIndicator();// while state loading, circule design kami

                    }

                    return CustomButton(

                      text: "Login",

                      onPressed: () {

                        if (formKey.currentState!.validate()) { //Form-la irukkura ella fields-um valid ah nu check pannudhu.

                          context.read<AuthBloc>().add(

                            LoginEvent(

                              email: emailController.text,

                              password: passwordController.text,

                            ),

                          );

                        }

                      },

                    );

                  },

                ),

                const SizedBox(height: 20),

                TextButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => SignupScreen(),

                      ),

                    );

                  },

                  child: const Text(

                    "Don't have an account? Signup",

                  ),

                )

              ],

            ),

          ),

        ),

      ),

    );

  }

}