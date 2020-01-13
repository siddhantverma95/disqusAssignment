import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assign/core/models/login_entity.dart';
import 'package:flutter_assign/core/services/repository/login_repository.dart';
import 'package:flutter_assign/ui/views/posts_view.dart';
import 'package:flutter_assign/utils/pref.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginStateInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is PerformLogin){
      yield LoginStateLoading();
      LoginRepository loginRepository = new LoginRepository();
      final response = await loginRepository.getLoginResults(event.context);
      print("RES: $response");
      if(response != null) {
        
        LoginEntity login = LoginEntity.fromJson(json.decode(response));
      if(!await PrefConfig.getIsLogin()){
        await Future.delayed(Duration(seconds: 2));
        bool status = await PrefConfig.setIsLogin(true);
        if(status) 
        Navigator.of(event.context).pushReplacement(MaterialPageRoute(builder:(context)=> PostsView(
          login: login,
        )));
        else yield LoginStateError();
      }else{
        Navigator.of(event.context).pushReplacement(MaterialPageRoute(builder:(context)=> PostsView(
          login: login,
        )));
      }
    }else{
        yield LoginStateError();
      }
    }
  }
}
