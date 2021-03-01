import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sevenbutlers/core/auth/login/login_repository.dart';
import './bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  @override
  SplashScreenState get initialState => InitialSplashScreenState();

  LoginRepository _repository = LoginRepository();

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is RefreshToken) {
      yield OnProgressRefreshToken();

      String result = await _repository.refreshToken();
      print("result refresh token: $result");
      if (result == "Success") {
        yield OnSuccessRefreshToken();
      } else
        yield OnErrorRefreshToken();
    }
  }
}
