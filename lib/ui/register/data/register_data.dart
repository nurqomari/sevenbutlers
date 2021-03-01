class RegistrationData {
  bool isRegister = false;
  bool isError = false;
  String data;
  bool onProgress = false;

  String first_name;
  String last_name;
  String username;
  String email;

  RegistrationData(this.isRegister, this.data, this.isError);

  RegistrationData.init() {
    isRegister = false;
    isError = false;
    data = null;
    onProgress = false;
  }

  RegistrationData.parse(responseData) {
    try {
      first_name = responseData['first_name'];
      last_name = responseData['last_name'];
      username = responseData['username'];
      email = responseData['email'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }
}
