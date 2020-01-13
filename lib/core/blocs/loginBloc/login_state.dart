import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assign/core/models/login_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginStateLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState{
  @override
  
  List<Object> get props => null;
}

class LoginStateError extends LoginState{
  @override
  List<Object> get props => null;
}
