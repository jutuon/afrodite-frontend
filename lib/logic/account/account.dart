import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account.freezed.dart';

@freezed
class AccountData with _$AccountData {
  factory AccountData({
    AccountIdLight? accountId,
    ApiKey? apiKey,
    required Capabilities capabilities,
  }) = _AccountData;
}

abstract class AccountEvent {}
class DoRegister extends AccountEvent {
  final String? serverAddress;
  DoRegister(this.serverAddress);
}
class DoLogin extends AccountEvent {}
class NewAccountIdValue extends AccountEvent {
  final AccountIdLight value;
  NewAccountIdValue(this.value);
}
class NewApiKeyValue extends AccountEvent {
  final ApiKey value;
  NewApiKeyValue(this.value);
}
class NewCapabilitiesValue extends AccountEvent {
  final Capabilities value;
  NewCapabilitiesValue(this.value);
}

/// Do register/login operations
class AccountBloc extends Bloc<AccountEvent, AccountData> {
  final AccountRepository account;

  AccountBloc(this.account) : super(AccountData(capabilities: Capabilities())) {
    // TODO: It is possible to start register and login multiple times?
    on<DoRegister>((data, emit) async {
      final address = data.serverAddress;
      if (address != null) {
        await account.setCurrentServerAddress(address);
      }
      emit(state.copyWith(
        accountId: await account.register(),
        apiKey: null,
      ));
    });
    on<DoLogin>((_, emit) async {
      emit(state.copyWith(
        apiKey: await account.login(),
      ));
    });
    on<NewAccountIdValue>((id, emit) {
      emit(state.copyWith(accountId: id.value));
    });
    on<NewApiKeyValue>((key, emit) {
      emit(state.copyWith(apiKey: key.value));
    });
    on<NewCapabilitiesValue>((key, emit) {
      emit(state.copyWith(capabilities: key.value));
    });

    account.capabilities.listen((event) {
      add(NewCapabilitiesValue(event));
    });

    // TODO: Does the following work?
    account.currentAccountId().whereNotNull().listen((event) {
      add(NewAccountIdValue(event));
    });
    account.currentApiKey().whereNotNull().listen((event) { add(NewApiKeyValue(event)); });
  }
}
