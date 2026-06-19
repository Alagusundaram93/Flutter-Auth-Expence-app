import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/shared_pref_helper.dart';

import '../../blocs/expense_bloc/expense_bloc.dart';
import '../../blocs/expense_bloc/expense_event.dart';
import '../../blocs/expense_bloc/expense_state.dart';

import '../login/login_screen.dart';
import '../add_expense/add_expense_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    super.initState();

    context.read<ExpenseBloc>().add(

      GetExpensesEvent(),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Expenses"),

        actions: [

          IconButton(

            onPressed: () async {

              await SharedPrefHelper.clearToken();

              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(

                  builder: (_) => const LoginScreen(),

                ),

                (route) => false,

              );

            },

            icon: const Icon(

              Icons.logout,

            ),

          ),

        ],

      ),

      body: BlocBuilder<ExpenseBloc, ExpenseState>(

        builder: (context, state) {

          if (state is ExpenseLoading) {

            return const Center(

              child: CircularProgressIndicator(),

            );

          }

          if (state is ExpenseLoaded) {

            return ListView.builder(

              itemCount: state.expenses.length,

              itemBuilder: (context, index) {

                final expense =

                    state.expenses[index];

                return Card(

                  margin:

                  const EdgeInsets.all(10),

                  child: ListTile(

                    title: Text(

                      expense.title,

                    ),

                    trailing: Text(

                      "₹ ${expense.amount}",

                    ),

                  ),

                );

              },

            );

          }

          return const SizedBox();

        },

      ),

      floatingActionButton:

      FloatingActionButton(

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>

                  const AddExpenseScreen(),

            ),

          );

        },

        child: const Icon(

          Icons.add,

        ),

      ),

    );

  }

}