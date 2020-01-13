import 'comment_entity.dart';

class PostsEntity {
  int id;
  int userId;
  String userName;
  String userImage;
  String title;
  String description;
  String image;
  bool like;
  bool dislike;
  String createdAt;
  String updatedAt;
  List<CommentsEntity> comments;

  PostsEntity(
      {this.id,
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

  PostsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    like = json['like'];
    dislike = json['dislike'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['comments'] != null) {
      comments = new List<CommentsEntity>();
      json['comments'].forEach((v) {
        comments.add(new CommentsEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}