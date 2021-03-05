import 'package:sevenbutlers/ui/register/data/resend_verification_data.dart';

class ResendVerificationState {
  final ResendVerificationData data;

  ResendVerificationState(this.data);

  factory ResendVerificationState.initial() =>
      ResendVerificationState(ResendVerificationData(false, null, false));
}
