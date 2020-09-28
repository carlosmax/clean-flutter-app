import 'package:test/test.dart';

import 'package:ForDev/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_email');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('test@gmail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('invalid_email'), 'Campo inválido');
  });
}