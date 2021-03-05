import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/core/register/register_repository.dart';
import 'package:sevenbutlers/ui/register/data/register_data.dart';
import 'package:sevenbutlers/ui/register/events/register_event.dart';
import 'package:sevenbutlers/ui/register/events/register_state.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  @override
  RegistrationState get initialState => RegistrationState.initial();

  void attemptRegister(
      String firstname, String lastname, String email, String password) {
    add(AttemptRegisterEvent(firstname, lastname, email, password));
  }

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is AttemptRegisterEvent) {
      final params = event;
      RegistrationData result;
      result = RegistrationData.init();
      result.onProgress = true;
      yield RegistrationState(result);

      var repository = RegistrationRepository();
      final response = await repository.attemptRegister(
          params.firstname, params.lastname, params.email, params.password);

      if (response.isRegister) {
        print("registration data: " + response.data.toString());

        result = RegistrationData(true, response.data, false);
        SessionManager session = SessionManager();
        session.setRegistrationData(
            params.firstname, params.lastname, params.email);
      } else {
        result = response;
      }

      yield RegistrationState(result);
    }
  }
}
