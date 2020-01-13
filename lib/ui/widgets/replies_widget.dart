import 'package:flutter/material.dart';
import 'package:flutter_assign/core/blocModels/replies.dart';
import 'package:flutter_assign/core/blocs/postBloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RepliesView extends StatelessWidget {
  const RepliesView({Key key, @required this.replies, @required this.commentId}) : super(key: key);
  final List<Replies> replies;
  final int commentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: Column(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: replies.length,
                    itemBuilder: (context, index) {
                      Replies comment = replies.elementAt(index);
                      return ReplyListTile(
                        reply: comment,
                        commentId: commentId,
                      );
                    }),
              ],
            ),
    );
  }
}

class ReplyListTile extends StatelessWidget {
  final Replies reply;
  final int commentId;
  const ReplyListTile({Key key, @required this.reply, @required this.commentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ListTile(
          leading: new Container(
              width: 35.0,
              height: 35.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(reply.userImage)))),
          title: Text(reply.userName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                    DateFormat.yMMMd().add_jm().format(DateTime.parse(reply.createdAt)),
                    style: TextStyle(fontSize: 12),
                  ),
              SizedBox(
                height: 8,
              ),
              Text(reply.reply),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context)..add(PerformReplyLike(replyId: reply.id,
                        commentId: commentId));
                      },
                      icon: Icon(Icons.thumb_up),
                      color: reply.like ? Colors.blue : Colors.black),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context)..add(PerformReplyDislike(
                        commentId: commentId,
                        replyId: reply.id

                      ));
                    },
                    icon: Icon(Icons.thumb_down),
                    color: reply.dislike ? Colors.red : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  }