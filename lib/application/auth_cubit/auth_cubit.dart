import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/domain/auth/i_auth_client.dart';
import 'package:saglixen/domain/auth/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final IAuthClient _authClient;

  AuthCubit(this._authClient) : super(AuthCubitState.initial());

  Future<void> initialize() {
    return _getUser();
  }

  Future<void> loginAnonymus() async {
    emit(
      state.copyWith(
        singInFailOption: none(),
        userOption: none(),
        isSingingIn: true,
      ),
    );

    final failOrTokens = await _authClient.loginAnonymus();
    failOrTokens.fold((failure) {
      emit(
        state.copyWith(
          singInFailOption: some(failure),
          isSingingIn: false,
        ),
      );
      return;
    }, (_) => null);
    if (state.singInFailOption.isSome()) return;

    await _getUser();
  }

  Future<void> _getUser() async {
    final getUserOrFail = await _authClient.getUser();

    emit(
      state.copyWith(
        singInFailOption: none(),
        userOption: none(),
        isSingingIn: true,
      ),
    );

    return getUserOrFail.fold(
      (failure) => emit(
        state.copyWith(
          singInFailOption: some(failure),
          isSingingIn: false,
        ),
      ),
      (user) => emit(
        state.copyWith(userOption: some(user), isSingingIn: false),
      ),
    );
  }
}
