import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/expense_bloc/expense_bloc.dart';
import '../../blocs/expense_bloc/expense_event.dart';

class AddExpenseScreen extends StatefulWidget {

  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();

}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final formKey = GlobalKey<FormState>();

  final titleController =TextEditingController();

  final amountController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              TextFormField(

                controller: titleController,

                decoration:
                    const InputDecoration(

                  hintText: "Expense Title",

                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Enter Title";

                  }
                  return null;

                },

              ),
              const SizedBox(height: 20),

              TextFormField(

                controller: amountController,

                keyboardType:
                    TextInputType.number,

                decoration:
                    const InputDecoration(

                  hintText: "Expense Amount",

                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Enter Amount";

                  }

                  return null;

                },

              ),

              const SizedBox(height: 30),

              ElevatedButton(

                onPressed: () {

                  if (formKey.currentState!.validate()) {

                    context
                        .read<ExpenseBloc>()
                        .add(

                      AddExpenseEvent(

                        title:
                            titleController.text,

                        amount:

                        double.parse(

                          amountController.text,

                        ),

                      ),

                    );

                    Navigator.pop(context);

                  }

                },

                child:const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}