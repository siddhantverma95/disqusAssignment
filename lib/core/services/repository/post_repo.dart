import 'package:flutter/material.dart';
import 'package:flutter_assign/core/services/network/api_base_helper.dart';
import 'dart:async';

class PostsRepository{
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();

  Future<dynamic> getPostsResults(BuildContext context) async {
    try {
      String response = await DefaultAssetBundle.of(context).loadString('assets/posts.json');
      return response;
    } catch (e) {
      return null;
    }}

    Future<dynamic> getMoreResults(BuildContext context) async {
    try {
      String response = await DefaultAssetBundle.of(context).loadString('assets/comments.json');
      return response;
    } catch (e) {
      return null;
    }}
    
    Future<dynamic> setPostsResult(String posts) async {
    try {
      //getFileData('assets/text/');
    } catch (e) {
      return null;
    }}
}