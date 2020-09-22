import 'package:ForDev/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  T _findDescendantWidget<T>(String key) {
    return find
        .descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(T),
        )
        .evaluate()
        .first
        .widget as T;
  }

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextField = _findDescendantWidget<TextField>('txtEmail');
    final passwordTextField = _findDescendantWidget<TextField>('txtPassword');
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(emailTextField.decoration.errorText, null);
    expect(passwordTextField.decoration.errorText, null);
    expect(button.onPressed, null);
  });
}
