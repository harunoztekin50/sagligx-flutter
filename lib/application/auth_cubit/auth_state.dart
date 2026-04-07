part of 'auth_cubit.dart';

final class AuthCubitState extends Equatable {
  const AuthCubitState({
    required this.userOption,
    required this.processFailOption,
    required this.isProcessing,
  });

  final Option<UserModel> userOption;
  final Option<Failure> processFailOption;
  final bool isProcessing;

  factory AuthCubitState.initial() {
    return AuthCubitState(
      userOption: None(),
      processFailOption: None(),
      isProcessing: false,
    );
  }

  AuthCubitState copyWith({
    Option<UserModel>? userOption,
    Option<Failure>? processFailOption,
    bool? isProcessing,
  }) {
    return AuthCubitState(
      userOption: userOption ?? this.userOption,
      processFailOption: processFailOption ?? this.processFailOption,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  @override
  List<Object?> get props => [
    userOption,
    processFailOption,
    isProcessing,
  ];
}
