import '../entities/index.dart';

abstract class LoadCurrentAccount {
  Future<Account> load();
}
