class RepliesEntity {
  int id;
  int userId;
  int postId;
  String userName;
  String userImage;
  String reply;
  bool like;
  bool dislike;
  String createdAt;
  String updatedAt;

  RepliesEntity(
      {this.id,
      this.userId,
      this.postId,
      this.userName,
      this.userImage,
      this.reply,
      this.like,
      this.dislike,
      this.createdAt,
      this.updatedAt});

  RepliesEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    postId = json['postId'];
    userName = json['userName'];
    userImage = json['userImage'];
    reply = json['reply'];
    like = json['like'];
    dislike = json['dislike'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['reply'] = this.reply;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}