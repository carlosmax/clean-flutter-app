import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:ForDev/presentation/presenters/stream_login_presentation.dart';
import 'package:ForDev/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(field: 'email', value: 'error');
    
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
