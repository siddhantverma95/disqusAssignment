
import 'replies_entity.dart';

class CommentsEntity {
  int id;
  int userId;
  int postId;
  String userName;
  String userImage;
  String comment;
  bool like;
  bool dislike;
  String createdAt;
  String updatedAt;
  List<RepliesEntity> replies;

  CommentsEntity(
      {this.id,
      this.userId,
      this.postId,
      this.userName,
      this.userImage,
      this.comment,
      this.like,
      this.dislike,
      this.createdAt,
      this.updatedAt,
      this.replies});

  CommentsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postId = json['postId'];
    userName = json['userName'];
    userImage = json['userImage'];
    comment = json['comment'];
    like = json['like'];
    dislike = json['dislike'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['replies'] != null) {
      replies = new List<RepliesEntity>();
      json['replies'].forEach((v) {
        replies.add(new RepliesEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['comment'] = this.comment;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}