import 'dart:convert'; //json data and dart object

import 'package:http/http.dart' as http;

class AuthApiService {

  Future<Map<String, dynamic>> login({

    required String email,

    required String password,

  }) async {

    final response = await http.post(

      Uri.parse('https://dummyjson.com/auth/login'),

      headers: {

        'Content-Type': 'application/json', //api-ku json data send pannudhu nu solludhu

      },

      body: jsonEncode({

        'username': email,

        'password': password,

      }),

    );
    print(response.statusCode);

    print(response.body);

    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Invalid Username or Password");
    }
  }

}