import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/cache/save_secure_cache_storage.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({this.secureStorage});

  Future<void> saveSecure(
      {@required String key, @required String value}) async {
    await this.secureStorage.write(key: key, value: value);
  }
}