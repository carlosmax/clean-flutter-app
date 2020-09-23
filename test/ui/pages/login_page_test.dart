import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ForDev/ui/pages/pages.dart';

import '../../helpers/finder_helper.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextField =
        FinderHelper.findDescendantWidget<TextField>('txtEmail');
    final passwordTextField =
        FinderHelper.findDescendantWidget<TextField>('txtPassword');
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(emailTextField.decoration.errorText, null);
    expect(passwordTextField.decoration.errorText, null);
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.byKey(Key('txtEmail')), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.byKey(Key('txtPassword')), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present an error if email is invalid',
      (WidgetTester tester) async {
    final errorMsg = 'any error';

    await loadPage(tester);

    emailErrorController.add(errorMsg);
    await tester.pump();

    final emailTextField =
        FinderHelper.findDescendantWidget<TextField>('txtEmail');

    expect(emailTextField.decoration.errorText, errorMsg);
  });
}
