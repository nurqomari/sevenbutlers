class ResendVerificationData {
  bool isSent = false;
  bool isError = false;
  String data;
  bool onProgress = false;
  String email;

  ResendVerificationData(this.isSent, this.data, this.isError);

  ResendVerificationData.init() {
    isSent = false;
    isError = false;
    data = null;
    onProgress = false;
  }

  ResendVerificationData.parse(responseData) {
    try {
      data = responseData['message'];
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }
}
