import '../models/user_model.dart';
import '../services/auth_api_service.dart';

class AuthRepository {

  final AuthApiService apiService;

  AuthRepository(this.apiService);

  Future<UserModel> login(

      String email,

      String password,

      ) async {

    final response = await apiService.login( //actually call api service to login user and get response

      email: email,

      password: password,

    );

    return UserModel.fromJson(response);

  }

}