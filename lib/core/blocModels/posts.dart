import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assign/core/blocModels/comments.dart';
import 'package:flutter_assign/core/models/post_entity.dart';

@immutable
class Posts extends Equatable{
  final int id;
  final int userId;
  final String userName;
  final String userImage;
  final String title;
  final String description;
  final String image;
  final bool like;
  final bool dislike;
  final String createdAt;
  final String updatedAt;
  final List<Comments> comments;

  Posts({this.id, 
  this.userId, 
  this.userName, 
  this.userImage, 
  this.title, 
  this.description, 
  this.image, 
  this.like, 
  this.dislike, 
  this.createdAt, 
  this.updatedAt, 
  this.comments});

  @override
  List<Object> get props => [comments, createdAt,description, dislike, id, image, like, title, updatedAt,
  userId, userImage, userName];

  Posts copyWith({
    int id,
  int userId,
  String userName,
  String userImage,
  String title,
  String description,
  String image,
  bool like,
  bool dislike,
  String createdAt,
  String updatedAt,
  List<Comments> comments,
    }) => 
        Posts(
            userId: userId ?? this.userId,
            id: id ?? this.id,
            userName: userName ?? this.userName,
            userImage: userImage ?? this.userImage,
            like: like ?? this.like,
            dislike: dislike ?? this.dislike,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            comments: comments ?? this.comments,
            description: description ?? this.description,
            image: image ?? this.image,
            title: title ?? this.title,
        );

  PostsEntity toEntity(){
    return PostsEntity(
      comments: comments.map((f)=> f.toEntity()),
      createdAt: createdAt,
      description: description,
      dislike: dislike,
      id: id,
      image: image,
      like: like,
      title: title,
      updatedAt: updatedAt,
      userId: userId,
      userImage: userImage,
      userName: userName,
    );
  }

  static Posts fromEntity(PostsEntity entity){
    return Posts(
      comments: entity.comments.map((f) => Comments.fromEntity(f)).toList(),
      createdAt: entity.createdAt,
      description: entity.description,
      dislike: entity.dislike,
      id: entity.id,
      image: entity.image,
      like: entity.like,
      title: entity.title,
      updatedAt: entity.updatedAt,
      userId: entity.userId,
      userImage: entity.userImage,
      userName: entity.userName,
    );
  }
}