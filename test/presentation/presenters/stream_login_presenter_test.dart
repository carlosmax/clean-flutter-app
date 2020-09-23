import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class ValidationSpy extends Mock implements Validation {}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();
  final Validation validation;

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({@required this.validation});

  void dispose() {
    _controller.close();
  }

  void validateEmail(String email) {
    _state.emailError = this.validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    when(validation.validate(
            field: anyNamed('field'), value: anyNamed('value')))
        .thenReturn('error');

    expectLater(sut.emailErrorStream, emits('error'));
    sut.validateEmail(email);
  });
}
