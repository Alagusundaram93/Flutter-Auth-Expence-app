class ExpenseApiService {

  Future<List<Map<String,dynamic>>>

  getExpenses() async {

    await Future.delayed(

      const Duration(seconds:2),

    );

    return [

      {

        "id":1,

        "title":"Food",

        "amount":500

      },

      {

        "id":2,

        "title":"Travel",

        "amount":1000

      }

    ];

  }

}