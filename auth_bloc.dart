import '../../../data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{ // auth event ah auth state ah convert pannudhu, event ah state ah map pannudhu
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) { //initial state ah auth initial state ah set pannudhu
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try{
        final user = await repository.login(
          event.email,
          event.password,
        );
        emit(AuthSuccess(user));

      }

      catch(e){
        emit(
          AuthFailure(
            e.toString(),
          ),
        );
      }
    });
  }
}