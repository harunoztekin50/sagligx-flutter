import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/core/extension/dart_extension.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/domain/auth/i_auth_client.dart';
import 'package:saglixen/domain/auth/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final IAuthClient _authClient;

  AuthCubit(this._authClient) : super(AuthCubitState.initial());

  Future<void> logOut() async {
    emit(
      state.copyWith(processFailOption: none(), isProcessing: true),
    );

    final failOrUnit = await _authClient.logOut();

    emit(
      state.copyWith(
        processFailOption: failOrUnit.toLeftOption(),
        isProcessing: false,
        userOption: failOrUnit.isRight() ? none() : null,
      ),
    );
  }

  Future<void> initialize() {
    return _getUser();
  }

  Future<void> loginAnonymus() async {
    if (state.isProcessing) return;

    debugPrint('CUBIT: loginAnonymus çağrıldı'); // ← bu yazıyor mu?

    emit(
      state.copyWith(
        processFailOption: none(),
        userOption: none(),
        isProcessing: true,
      ),
    );

    final failOrTokens = await _authClient.loginAnonymus();
    failOrTokens.fold((failure) {
      emit(
        state.copyWith(
          processFailOption: some(failure),
          isProcessing: false,
        ),
      );
      return;
    }, (_) => null);
    if (state.processFailOption.isSome()) return;

    await _getUser();
  }

  Future<void> _getUser() async {
    emit(
      state.copyWith(
        processFailOption: none(),
        userOption: none(),
        isProcessing: true,
      ),
    );

    final getUserOrFail = await _authClient.getUser();

    return getUserOrFail.fold(
      (failure) => emit(
        state.copyWith(
          processFailOption: some(failure),
          isProcessing: false,
        ),
      ),
      (user) => emit(
        state.copyWith(userOption: some(user), isProcessing: false),
      ),
    );
  }
}
