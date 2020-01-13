import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assign/core/blocModels/posts.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostStateLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostStateLoaded extends PostState {
  final Posts obj;
  
  PostStateLoaded({@required this.obj});
  @override
  List<Object> get props => [obj];
}

class PostStateError extends PostState {
  final String errorMessaage;

  PostStateError({@required this.errorMessaage});
  @override
  List<Object> get props => [];
}
