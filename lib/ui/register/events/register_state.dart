import 'package:sevenbutlers/ui/register/data/register_data.dart';

class RegistrationState {
  final RegistrationData data;

  RegistrationState(this.data);

  factory RegistrationState.initial() =>
      RegistrationState(RegistrationData(false, null, false));
}
