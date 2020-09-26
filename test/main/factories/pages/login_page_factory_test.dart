import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

import 'package:ForDev/main/factories/pages/login/login_page_factory.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
