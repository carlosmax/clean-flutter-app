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
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    await sut.checkAccount();
    verify(loadCurrentAccount.load()).called(1);
  });
}
