import 'package:sevenbutlers/core/register/register_api_provider.dart';
import 'package:sevenbutlers/ui/register/data/register_data.dart';

class RegistrationRepository {
  final registerProvider = RegisterApiProvider();

  Future<RegistrationData> attemptRegister(
          String firstname, String lastname, String email, String password) =>
      registerProvider.register(firstname, lastname, email, password);
}
