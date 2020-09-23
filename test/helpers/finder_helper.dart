import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class FinderHelper {
  static T findDescendantWidget<T>(String key) {
    return find
        .descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(T),
        )
        .evaluate()
        .first
        .widget as T;
  }
}