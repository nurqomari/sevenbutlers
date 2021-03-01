import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSplashScreenState extends SplashScreenState {}

class OnProgressRefreshToken extends SplashScreenState {}

class OnSuccessRefreshToken extends SplashScreenState {}

class OnErrorRefreshToken extends SplashScreenState {}
