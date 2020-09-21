import '../http/index.dart';
import '../../domain/entities/index.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) throw HttpError.invalidData;

    return RemoteAccountModel(json['accessToken']);
  }

  Account toEntity() => Account(this.accessToken);
}
