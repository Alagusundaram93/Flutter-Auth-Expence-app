import '../models/expense_model.dart';

import '../services/expense_api_service.dart';

class ExpenseRepository {

 final ExpenseApiService api;

 ExpenseRepository(this.api);

 Future<List<ExpenseModel>>

 getExpenses() async {

   final response=

   await api.getExpenses();

   return response

       .map(

         (e)=>

         ExpenseModel.fromJson(e),

       )

       .toList();

 }

}