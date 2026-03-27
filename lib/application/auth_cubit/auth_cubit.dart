import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/domain/auth/i_auth_client.dart';
import 'package:saglixen/domain/auth/user_model.dart';
import 'package:saglixen/domain/failure/failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(this._authClient) : super(AuthCubitState.initial());

  Future<void> loginAnonymus() async {
    emit(AuthCubitState.initial());

    final failORtokens = await _authClient.loginAnonymus();

    if (failORtokens.isLeft()) {
      final failure = failORtokens.fold((f) => f, (_) => throw StateError(""));
      emit(state.copyWith(singInFailOption: some(failure)));
      return;
    }
  }

  final IAuthClient _authClient;
}
