import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../domain/usecases/index.dart';
import '../../../../data/usecases/index.dart';
import '../../../../infra/index.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/splash/splash_page.dart';

Widget makeSplashPage() {
  final presenter = GetXSplashPresenter(
    loadCurrentAccount: makeLoadCurrentAccount(),
  );
  return SplashPage(presenter: presenter);
}

LoadCurrentAccount makeLoadCurrentAccount() {
  final secureStorage = FlutterSecureStorage();
  final localStorageAdapter = LocalStorageAdapter(secureStorage: secureStorage);

  return LocalLoadCurrentAccount(fetchSecureCacheStorage: localStorageAdapter);
}