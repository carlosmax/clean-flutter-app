import 'package:ForDev/domain/entities/index.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/foundation.dart';

import 'package:ForDev/ui/pages/splash/splash_presenter.dart';
import 'package:ForDev/domain/usecases/load_current_account.dart';

class GetXSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  var _navigateTo = RxString();

  GetXSplashPresenter({@required this.loadCurrentAccount});

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();
    _navigateTo.value = account.isNull ? '/login' : '/surveys';
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;
  GetXSplashPresenter sut;

  void mockLoadCurrentAccount({Account account}) {
    when(loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: Account(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();
    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));
    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/login')));
    await sut.checkAccount();
  });
}
