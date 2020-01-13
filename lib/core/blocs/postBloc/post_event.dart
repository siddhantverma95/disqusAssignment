import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}
class PerformPostRequest extends PostEvent{
  final BuildContext context;

  PerformPostRequest({@required this.context});
  @override
  List<Object> get props => null;

}

class PerformPostLike extends PostEvent{
  final int postId;

  PerformPostLike({@required this.postId});
  @override
  List<Object> get props => [postId];

}

class PerformPostDislike extends PostEvent{
  final int postId;

  PerformPostDislike({@required this.postId});
  @override
  List<Object> get props => [postId];

}

class PerformPostComment extends PostEvent{
  final String comment;
  
  PerformPostComment({@required this.comment,});
  List<Object> get props => [comment];

}

class PerformCommentLike extends PostEvent{
  final int commentId;

  PerformCommentLike({@required this.commentId});
  @override
  List<Object> get props => [commentId];

}

class PerformCommentDislike extends PostEvent{
  final int commentId;

  PerformCommentDislike({@required this.commentId});
  @override
  List<Object> get props => [commentId];

}

class PerformCommentReply extends PostEvent{
  final String reply;
  final int commentId;
  
  PerformCommentReply({@required this.reply, @required this.commentId});
  List<Object> get props => [reply, commentId];

}
class PerformLoadMoreComments extends PostEvent{
  final BuildContext context;

  PerformLoadMoreComments({@required this.context});
  List<Object> get props => [];

}

class PerformReplyLike extends PostEvent{
  final int replyId;
  final int commentId;

  PerformReplyLike({@required this.replyId, @required this.commentId});
  @override
  List<Object> get props => [replyId];

}

class PerformReplyDislike extends PostEvent{
  final int replyId;
  final int commentId;

  PerformReplyDislike({@required this.replyId, @required this.commentId});
  @override
  List<Object> get props => [replyId];

}