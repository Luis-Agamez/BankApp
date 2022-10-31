part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool existsUser;
  final bool loading;
  final User? user;
  final List<AccountElement> saving;
  final List<AccountElement> stream;
  final List<Result> transfers;
  final List<AccountSaved> accountsSavingRegistered;
  final List<AccountSaved> accountsStreamRegistered;

  const AuthState({
    this.existsUser = false,
    this.loading = false,
    this.user = null,
    this.saving = const [],
    this.stream = const [],
    this.transfers = const [],
    this.accountsSavingRegistered = const [],
    this.accountsStreamRegistered = const [],
  });

  AuthState copyWith(
          {final bool? existsUser,
          final bool? loading,
          final User? user,
          final List<AccountElement>? saving,
          final List<AccountElement>? stream,
          final List<Result>? transfers,
          final List<AccountSaved>? accountsSavingRegistered,
          final List<AccountSaved>? accountsStreamRegistered}) =>
      AuthState(
        existsUser: existsUser ?? this.existsUser,
        loading: loading ?? this.loading,
        user: user ?? this.user,
        saving: saving ?? this.saving,
        stream: stream ?? this.stream,
        transfers: transfers ?? this.transfers,
        accountsSavingRegistered:
            accountsSavingRegistered ?? this.accountsSavingRegistered,
        accountsStreamRegistered:
            accountsStreamRegistered ?? this.accountsStreamRegistered,
      );

  @override
  List<Object?> get props => [
        existsUser,
        user,
        loading,
        saving,
        stream,
        transfers,
        accountsSavingRegistered,
        accountsStreamRegistered
      ];
}
