import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/core/register/register_repository.dart';
import 'package:sevenbutlers/ui/register/data/resend_verification_data.dart';
import 'package:sevenbutlers/ui/register/events/resend_verification_event.dart';
import 'package:sevenbutlers/ui/register/events/resend_verification_state.dart';

class ResendVerificationBloc
    extends Bloc<ResendVerificationEvent, ResendVerificationState> {
  @override
  ResendVerificationState get initialState => ResendVerificationState.initial();

  void attemptResendVerification(String email) {
    add(AttemptResendVerificationEvent(email));
  }

  @override
  Stream<ResendVerificationState> mapEventToState(
      ResendVerificationEvent event) async* {
    if (event is AttemptResendVerificationEvent) {
      final params = event;
      ResendVerificationData result;
      result = ResendVerificationData.init();
      result.onProgress = true;
      yield ResendVerificationState(result);

      var repository = RegistrationRepository();
      final response = await repository.attemptResendVerification(params.email);

      if (response.isSent) {
        result = ResendVerificationData(true, response.data, false);
      } else {
        result = response;
      }

      yield ResendVerificationState(result);
    }
  }
}
