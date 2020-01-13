import 'package:flutter/material.dart';
import 'package:flutter_assign/core/services/network/api_base_helper.dart';

class LoginRepository{
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();

  Future<dynamic> getLoginResults(BuildContext context) async {
    try {
      String response = await DefaultAssetBundle.of(context).loadString('assets/login.json');
      return response;
    } catch (e) {
      return null;
    }}
}