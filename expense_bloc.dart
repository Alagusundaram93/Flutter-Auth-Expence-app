import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/expense_model.dart';
import '../../../data/repositories/expense_repository.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {

  final ExpenseRepository repository;

  ExpenseBloc(this.repository) : super(ExpenseInitial()) {

    on<GetExpensesEvent>(_getExpenses);

    on<AddExpenseEvent>(_addExpense);

  }

  final List<ExpenseModel> expenseList = [];

  Future<void> _getExpenses(

    GetExpensesEvent event,

    Emitter<ExpenseState> emit,

  ) async {

    emit(ExpenseLoading());

    try {

      final expenses = await repository.getExpenses();

      expenseList.clear();

      expenseList.addAll(expenses);

      emit(

        ExpenseLoaded(

          List.from(expenseList),

        ),

      );

    }

    catch (e) {

      emit(

        ExpenseError(

          e.toString(),

        ),

      );

    }

  }

  void _addExpense(

    AddExpenseEvent event,

    Emitter<ExpenseState> emit,

  ) {

    final expense = ExpenseModel(

      id: expenseList.length + 1,

      title: event.title,

      amount: event.amount,

    );

    expenseList.add(expense);

    emit(

      ExpenseLoaded(

        List.from(expenseList),

      ),

    );

  }

}