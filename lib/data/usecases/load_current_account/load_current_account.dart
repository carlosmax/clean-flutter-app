import 'package:flutter/material.dart';

import '../../cache/cache.dart';
import '../../../domain/entities/index.dart';
import '../../../domain/helpers/index.dart';
import '../../../domain/usecases/index.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  Future<Account> load() async {
    try {
      final token = await this.fetchSecureCacheStorage.fetchSecure('token');
      return Account(token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}