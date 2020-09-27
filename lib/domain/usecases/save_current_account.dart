import '../entities/index.dart';

abstract class SaveCurrentAccount {
  Future<void> save(Account account);
}
