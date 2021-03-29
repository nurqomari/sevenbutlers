class AppUrl {
  static const String liveBaseURL =
      "https://favorestodevapi.azurewebsites.net/v.1/";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = "https://favorestodevapi.azurewebsites.net/token";
  static const String register = baseURL + "register";
  static const String resendVerification = baseURL + "activation/resend";
  static const String socialLogin = baseURL + "account/token";
  static const String forgotPassword = baseURL + "forgot-password";
  static const String merchants = baseURL + "merchant";
}
