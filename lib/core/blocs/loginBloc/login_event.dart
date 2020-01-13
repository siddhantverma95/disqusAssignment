import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PerformLogin extends LoginEvent{
  final BuildContext context;

  PerformLogin({@required this.context,});
  @override
  List<Object> get props => [context];

}