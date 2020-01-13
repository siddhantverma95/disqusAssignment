import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_assign/core/blocModels/comments.dart';
import 'package:flutter_assign/core/blocModels/posts.dart';
import 'package:flutter_assign/core/blocModels/replies.dart';
import 'package:flutter_assign/core/models/post_entity.dart';
import 'package:flutter_assign/core/services/repository/post_repo.dart';
import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostStateLoading();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PerformPostRequest) {
      PostsRepository postsRepository = new PostsRepository();
      final response = await postsRepository.getPostsResults(event.context);
      if (response != null) {
        PostsEntity postEntity = PostsEntity.fromJson(json.decode(response));
        Posts posts = Posts.fromEntity(postEntity);
        yield PostStateLoaded(obj: posts);
      } else {
        yield PostStateError(
            errorMessaage: 'Something went wrong. Please try again later.');
      }
    }
     else if (event is PerformPostLike) {
      if (state is PostStateLoaded) {
        Posts currentObj = (state as PostStateLoaded).obj;
        if (!currentObj.like)
          currentObj = currentObj.copyWith(like: true, dislike: false);
        else
          currentObj = currentObj.copyWith(like: false);
        yield PostStateLoaded(obj: currentObj);
      }
    } else if (event is PerformPostDislike) {
      if (state is PostStateLoaded) {
        Posts currentObj = (state as PostStateLoaded).obj;
        if (!currentObj.dislike)
          currentObj = currentObj.copyWith(dislike: true, like: false);
        else
          currentObj = currentObj.copyWith(dislike: false);
        yield PostStateLoaded(obj: currentObj);
      }
    } else if (event is PerformPostComment) {
      if (state is PostStateLoaded) {
        DateTime now = DateTime.now();
        int min = 100, max = 10000;
        Random rnd = new Random(now.millisecondsSinceEpoch);
        int r = min + rnd.nextInt(max - min);
        Posts currentObj = (state as PostStateLoaded).obj;
        Comments comments = new Comments(
            id: r,
            comment: event.comment,
            createdAt: now.toString(),
            updatedAt: now.toString(),
            dislike: false,
            like: false,
            postId: currentObj.id,
            replies: [],
            userId: 100,
            userName: "Siddhant Verma",
            userImage:
                'https://www.irreverentgent.com/wp-content/uploads/2018/03/Awesome-Profile-Pictures-for-Guys-look-away2.jpg');
        List<Comments> currentComment = currentObj.comments;
        currentComment.insert(0, comments);
        currentObj.copyWith(comments: currentComment);
        yield PostStateLoaded(obj: currentObj);
      }
    } else if (event is PerformCommentLike) {
      if (state is PostStateLoaded) {
        Posts posts = (state as PostStateLoaded).obj;
        Posts updatedPost = (state as PostStateLoaded).obj.copyWith(
                comments: posts.comments.map((comment) {
              if (comment.id == event.commentId) {
                if (!comment.like)
                  return comment = comment.copyWith(like: true, dislike: false);
                else
                  return comment = comment.copyWith(like: false);
              } else
                return comment;
            }).toList());
        yield PostStateLoaded(obj: updatedPost);
      }
    } else if (event is PerformCommentDislike) {
      if (state is PostStateLoaded) {
        Posts posts = (state as PostStateLoaded).obj;
        Posts updatedPost = (state as PostStateLoaded).obj.copyWith(
                comments: posts.comments.map((comment) {
              if (comment.id == event.commentId) {
                if (!comment.dislike)
                  return comment = comment.copyWith(dislike: true, like: false);
                else
                  return comment = comment.copyWith(dislike: false);
              } else
                return comment;
            }).toList());
        yield PostStateLoaded(obj: updatedPost);
      }
    } else if (event is PerformCommentReply) {
      if (state is PostStateLoaded) {
        DateTime now = DateTime.now();
        int min = 100, max = 10000;
        Random rnd = new Random(now.millisecondsSinceEpoch);
        int r = min + rnd.nextInt(max - min);
        Posts posts = (state as PostStateLoaded).obj;
        Replies replies = new Replies(
            id: r,
            reply: event.reply,
            createdAt: now.toString(),
            updatedAt: now.toString(),
            dislike: false,
            like: false,
            postId: posts.id,
            userId: 100,
            userName: "Siddhant Verma",
            userImage:
                'https://www.irreverentgent.com/wp-content/uploads/2018/03/Awesome-Profile-Pictures-for-Guys-look-away2.jpg');
        Posts updatedPost = (state as PostStateLoaded).obj.copyWith(
                comments: posts.comments.map((comment) {
              if (comment.id == event.commentId) {
                List<Replies> replyList = comment.replies;
                replyList.insert(0, replies);
                return comment.copyWith(replies: replyList);
              } else
                return comment;
            }).toList());
        yield PostStateLoaded(obj: updatedPost);
      }
    }
     else if (event is PerformLoadMoreComments) {
      if (state is PostStateLoaded) {
        PostsRepository postsRepository = new PostsRepository();
        final response = await postsRepository.getMoreResults(event.context);
        if (response != null) {
            PostsEntity postEntity =
                PostsEntity.fromJson(json.decode(response));
            Posts morePosts = Posts.fromEntity(postEntity);
            Posts posts = (state as PostStateLoaded).obj;
            List<Comments> currentComment = List.from(posts.comments);
            currentComment.addAll(morePosts.comments);
            Posts updatedObj = posts.copyWith(comments: currentComment);
            yield PostStateLoaded(obj: updatedObj);
          }
      }
    } else if (event is PerformReplyLike) {
      if (state is PostStateLoaded) {
        Posts posts = (state as PostStateLoaded).obj;
        Posts updatedPost = (state as PostStateLoaded).obj.copyWith(
                comments: posts.comments.map((comment) {
              if (comment.id == event.commentId) {
                return comment.copyWith(
                    replies: comment.replies.map((reply) {
                  if (reply.id == event.replyId) {
                    if (!reply.like) {
                      reply = reply.copyWith(like: true, dislike: false);
                      return reply;
                    } else
                      return reply = reply.copyWith(like: false);
                  } else
                    return reply;
                }).toList());
              } else
                return comment;
            }).toList());
        yield PostStateLoaded(obj: updatedPost);
      }
    } else if (event is PerformReplyDislike) {
      Posts posts = (state as PostStateLoaded).obj;
      Posts updatedPost = (state as PostStateLoaded).obj.copyWith(
              comments: posts.comments.map((comment) {
            if (comment.id == event.commentId) {
              return comment.copyWith(
                  replies: comment.replies.map((reply) {
                if (reply.id == event.replyId) {
                  if (!reply.dislike) {
                    reply = reply.copyWith(dislike: true, like: false);
                    return reply;
                  } else
                    return reply = reply.copyWith(dislike: false);
                } else
                  return reply;
              }).toList());
            } else
              return comment;
          }).toList());
      yield PostStateLoaded(obj: updatedPost);
    }
  }
}
