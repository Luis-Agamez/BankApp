part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ActiveUser extends AuthEvent {
  final User user;
  const ActiveUser(this.user);
}

class CleanUser extends AuthEvent {}

class AutenticationActive extends AuthEvent {}

class AutenticationDesactive extends AuthEvent {}

class SetAccountsStream extends AuthEvent {
  final List<AccountElement> stream;
  const SetAccountsStream(this.stream);
}

class SetAccountsSaving extends AuthEvent {
  final List<AccountElement> saving;
  const SetAccountsSaving(this.saving);
}

class SetTranfersSend extends AuthEvent {
  final List<Result> transfers;
  const SetTranfersSend(this.transfers);
}

class SetAccountsSavingRegistered extends AuthEvent {
  final List<AccountSaved> accountsSavingRegistered;
  const SetAccountsSavingRegistered(this.accountsSavingRegistered);
}

class SetAccountsStreamdRegistered extends AuthEvent {
  final List<AccountSaved> accountsStreamRegistered;

  const SetAccountsStreamdRegistered(this.accountsStreamRegistered);
}
