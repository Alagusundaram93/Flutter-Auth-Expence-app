abstract class ExpenseEvent {}

class GetExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {

  final String title;

  final double amount;

  AddExpenseEvent({

    required this.title,

    required this.amount,

  });

}