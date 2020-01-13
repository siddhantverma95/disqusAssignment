import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assign/core/models/replies_entity.dart';

@immutable
class Replies extends Equatable{
  final int id;
  final int userId;
  final int postId;
  final String userName;
  final String userImage;
  final String reply;
  final bool like;
  final bool dislike;
  final String createdAt;
  final String updatedAt;

  Replies({this.id, this.userId, this.postId, this.userName, this.userImage, this.reply, this.like, this.dislike, this.createdAt, this.updatedAt});

  Replies copyWith({
    int id,
    bool like,
    bool dislike,
    int userId,
    int postId,
    String userName,
    String userImage,
    String reply,
    String createdAt,
    String updatedAt,
  }) {
    return Replies(
      id: id ?? this.id,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      reply: reply ?? this.reply,
    );
  }
  @override
  List<Object> get props => [
    id, userId, postId, userName, userImage, reply, like, dislike, createdAt, updatedAt,
  ];

  RepliesEntity toEntity(){
    return RepliesEntity(
      id: id,
      createdAt: createdAt,
      dislike: dislike,
      like: like,
      postId: postId,
      reply: reply,
      updatedAt: updatedAt,
      userId: userId,
      userImage: userImage,
      userName: userImage,
    );
  }

  static Replies fromEntity(RepliesEntity entity){
    return Replies(
      id: entity.id,
      createdAt: entity.createdAt,
      dislike: entity.dislike,
      like: entity.like,
      postId: entity.postId,
      reply: entity.reply,
      updatedAt: entity.updatedAt,
      userId: entity.userId,
      userImage: entity.userImage,
      userName: entity.userName,
    );
  }
}