import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assign/core/blocModels/replies.dart';
import 'package:flutter_assign/core/models/comment_entity.dart';

@immutable
class Comments extends Equatable{
  final int id;
  final int userId;
    final int postId;
    final String userName;
    final String userImage;
    final String comment;
    final bool like;
    final bool dislike;
    final String createdAt;
    final String updatedAt;
    final List<Replies> replies;

  Comments({
    this.id,
    this.userId, 
    this.postId, 
    this.userName, 
    this.userImage, 
    this.comment, 
    this.like, 
    this.dislike, 
    this.createdAt, 
    this.updatedAt, 
    this.replies, 
    });

    Comments copyWith({
      int id,
        int userId,
        int postId,
        String userName,
        String userImage,
        String comment,
        bool like,
        bool dislike,
        String createdAt,
        String updatedAt,
        List<Replies> replies,
        String reply,
    }) => 
        Comments(
          id: id ?? this.id,
            userId: userId ?? this.userId,
            postId: postId ?? this.postId,
            userName: userName ?? this.userName,
            userImage: userImage ?? this.userImage,
            comment: comment ?? this.comment,
            like: like ?? this.like,
            dislike: dislike ?? this.dislike,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            replies: replies ?? this.replies,
        );
  @override
  List<Object> get props => [
    id, userId, postId, comment, createdAt, dislike, like, postId, replies, updatedAt, userImage, userName 
  ];

  CommentsEntity toEntity(){
    return CommentsEntity(
      id: id,
      userId: userId,
      comment: comment,
      createdAt: createdAt,
      dislike: dislike,
      like: like,
      postId: postId,
      updatedAt: updatedAt,
      userImage: userImage,
      userName: userName,
      replies: (replies.map((f) => f.toEntity()) as List)
    );
  }
  static Comments fromEntity(CommentsEntity entity){
    return Comments(
      id: entity.id,
      comment: entity.comment,
      createdAt: entity.createdAt,
      dislike: entity.dislike,
      like: entity.like,
      postId: entity.postId,
      replies: entity.replies.map((f) => Replies.fromEntity(f)).toList(),
      updatedAt: entity.updatedAt,
      userId: entity.userId,
      userImage: entity.userImage,
      userName: entity.userName,
    );
  }
}
