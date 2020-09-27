import 'package:flutter/material.dart';

import '../../cache/save_secure_cache_storage.dart';
import '../../../domain/entities/index.dart';
import '../../../domain/helpers/index.dart';
import '../../../domain/usecases/save_current_account.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future<void> save(Account account) async {
    try {
      this
          .saveSecureCacheStorage
          .saveSecure(key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}