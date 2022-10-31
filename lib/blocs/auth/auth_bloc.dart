import 'dart:convert';
import 'package:bank/models/get_tranfers_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../global/enviroments.dart';
import '../../models/account_user_registered.dart';
import '../../models/accounts_user_response.dart';
import '../../models/auth_response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late User user;
  final _storage = const FlutterSecureStorage();

  AuthBloc() : super(const AuthState()) {
    on<ActiveUser>((event, emit) =>
        emit(state.copyWith(existsUser: true, user: event.user)));
    on<CleanUser>(
        (event, emit) => emit(state.copyWith(existsUser: false, user: null)));

    on<AutenticationActive>(
        (event, emit) => emit(state.copyWith(loading: true)));
    on<AutenticationDesactive>(
        (event, emit) => emit(state.copyWith(loading: false)));
    on<SetAccountsStream>(
        (event, emit) => emit(state.copyWith(stream: event.stream)));
    on<SetAccountsSaving>(
        (event, emit) => emit(state.copyWith(saving: event.saving)));
    on<SetTranfersSend>(
        (event, emit) => emit(state.copyWith(transfers: event.transfers)));
    on<SetAccountsSavingRegistered>((event, emit) => emit(state.copyWith(
        accountsSavingRegistered: event.accountsSavingRegistered)));
    on<SetAccountsStreamdRegistered>((event, emit) => emit(state.copyWith(
        accountsStreamRegistered: event.accountsStreamRegistered)));
  }

  Future register(String name, String email, String password) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    add(AutenticationActive());

    final uri = Uri.parse('${Environment.apiUrl}/auth/register');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 201) {
      final loginResponse = AuthResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _savedToken(loginResponse.token);
      add(ActiveUser(user));
      add(AutenticationDesactive());
      return true;
    } else {
      add(AutenticationDesactive());
    }
  }

  Future<bool> login(String email, String password) async {
    add(AutenticationActive());

    late User user;
    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/auth/login');

    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    add(AutenticationDesactive());
    if (resp.statusCode == 200) {
      final loginResponse = AuthResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _savedToken(loginResponse.token);
      add(ActiveUser(user));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAccountsStream() async {
    final token = await _storage.read(key: 'token');

    final uriStream = Uri.parse('${Environment.apiUrl}/accounts/stream');

    final respStream = await http.get(uriStream, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (respStream.statusCode == 200) {
      final accountResponse = AccountsUserResponse.fromJson(respStream.body);
      final account = accountResponse.accounts;
      add(SetAccountsStream(account));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAccountsSaving() async {
    final token = await _storage.read(key: 'token');
    final uriSaving = Uri.parse('${Environment.apiUrl}/accounts/saving');

    final respSaving = await http.get(uriSaving, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (respSaving.statusCode == 200) {
      final accountResponse = AccountsUserResponse.fromJson(respSaving.body);
      final account = accountResponse.accounts;
      add(SetAccountsSaving(account));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> GetTransfersSends() async {
    final token = await _storage.read(key: 'token');
    final uriTransfer = Uri.parse('${Environment.apiUrl}/transfers/send');
    final respTranfers = await http.get(uriTransfer, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (respTranfers.statusCode == 200) {
      final transfers = GetTransfersResponse.fromJson(respTranfers.body);
      add(SetTranfersSend(transfers.results));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendTokenQr(String token) async {
    final data = {
      'token': token,
    };
    final uriTransfer = Uri.parse('${Environment.apiUrl}/transfers/saved');

    final respTranfers =
        await http.post(uriTransfer, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (respTranfers.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getRegisteredStreamAccount() async {
    final token = await _storage.read(key: 'token');
    final uriTransfer = Uri.parse('${Environment.apiUrl}/registered/stream');

    final respTranfers = await http.get(uriTransfer, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (respTranfers.statusCode == 200) {
      final transfers =
          AccountsUserResponseRegistered.fromJson(respTranfers.body);
      add(SetAccountsStreamdRegistered(transfers.accountSaved));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getRegisteredSavingAccount() async {
    final token = await _storage.read(key: 'token');
    final uriTransfer = Uri.parse('${Environment.apiUrl}/registered/saving');

    final respTranfers = await http.get(uriTransfer, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (respTranfers.statusCode == 200) {
      final transfers =
          AccountsUserResponseRegistered.fromJson(respTranfers.body);
      add(SetAccountsSavingRegistered(transfers.accountSaved));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> idLogggedIn() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/auth/renew');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (resp.statusCode == 200) {
      final loginResponse = AuthResponse.fromJson(resp.body);
      user = loginResponse.user;
      add(ActiveUser(user));
      await _savedToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  logout<Void>() async {
    await _storage.delete(key: 'token');
    add(CleanUser());
  }

  Future _savedToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  void activeLoading() {
    add(AutenticationActive());
  }

  void desactiveLoading() {
    add(AutenticationDesactive());
  }

  Future<String> createTokenQr(String accountorigin, String accountdestiny,
      String amount, String money, String origin) async {
    final token = await _storage.read(key: 'token');
    bool us = false;
    if (money == 'US') {
      us = true;
    }
    final data = {
      'accountorigin': accountorigin,
      'accountdestiny': accountdestiny,
      'amount': int.parse(amount),
      "us": us,
      "origin": origin,
    };

    final uri = Uri.parse('${Environment.apiUrl}/transfers');

    final resp = await http.post(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(resp.body);
    if (resp.statusCode == 201) {
      return resp.body;
    } else {
      return 'false';
    }
  }
}
