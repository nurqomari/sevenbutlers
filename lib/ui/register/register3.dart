import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenbutlers/ui/register/events/resend_verification_bloc.dart';
import 'package:sevenbutlers/ui/register/events/resend_verification_state.dart';
import 'package:sevenbutlers/utils/helpers/hex_color.dart';

class Register3 extends StatefulWidget {
  final String email;
  Register3({Key key, @required this.email}) : super(key: key);

  @override
  _Register3State createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  ResendVerificationBloc resendVerificationBloc;

  @override
  void initState() {
    super.initState();
    resendVerificationBloc = BlocProvider.of<ResendVerificationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: BlocListener<ResendVerificationBloc, ResendVerificationState>(
              listener: (context, state) {
            // if (state.data.isRegister) {
            //   Navigator.pushNamedAndRemoveUntil(
            //       context, "/register3", (route) => false,
            //       arguments: {'email': _email});
            // }
          }, child:
                  BlocBuilder<ResendVerificationBloc, ResendVerificationState>(
                      builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login1", (route) => false);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Image.asset(
                              "assets/images/arrow-left.png",
                              width: 13.2,
                              height: 12.4,
                            ))),
                  ],
                ),
                SizedBox(height: 90),
                Center(
                    child: Image.asset(
                  "assets/images/mail.png",
                )),
                SizedBox(height: 40),
                Center(
                  child: Text(
                    "Confirm your",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "email soon",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "We’ve sent you an email with a link",
                    style: TextStyle(
                        color: HexColor("#898989"),
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "to confirm your email address.",
                    style: TextStyle(
                        color: HexColor("#898989"),
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "If you can’t find it,",
                    style: TextStyle(
                        color: HexColor("#898989"),
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "you should check your spam folder.",
                    style: TextStyle(
                        color: HexColor("#898989"),
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Visibility(
                    visible: state.data.onProgress,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: state.data.isError,
                    child: Text(
                      state.data.data ?? '',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Center(
                  child: Visibility(
                      visible: state.data.isSent,
                      child: Text(
                        "Activation email is resent to your email!",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          var email = widget.email;
                          resendVerificationBloc
                              .attemptResendVerification(email);
                        },
                        textColor: Colors.black,
                        color: HexColor("#e3e3e3"),
                        child: SizedBox(
                          width: 125,
                          child: Text(
                            "Resend",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        height: 45,
                        minWidth: 125,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login1", (route) => false);
                        },
                        textColor: Colors.white,
                        color: Colors.black,
                        child: SizedBox(
                          width: 125,
                          child: Text(
                            "OK, I've got it",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        height: 45,
                        minWidth: 125,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ],
                  ),
                )
              ],
            );
          })),
        ),
      ),
    );
  }
}
