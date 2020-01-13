import 'package:flutter/material.dart';
import 'package:flutter_assign/core/blocModels/comments.dart';
import 'package:flutter_assign/core/blocs/postBloc/bloc.dart';
import 'package:flutter_assign/ui/views/login_view.dart';
import 'package:flutter_assign/ui/widgets/replies_widget.dart';
import 'package:flutter_assign/utils/pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommentView extends StatefulWidget {
  const CommentView({Key key, @required this.comments}) : super(key: key);
  final List<Comments> comments;

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  TextEditingController _textEditingController;
  bool isReply = false;

  @override
  void initState() {
    _textEditingController = new TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    Comments comment = widget.comments.elementAt(index);
                    return CommentListTile(
                      comments: comment,
                    );
                  }),
                  FlatButton(onPressed: (){
                BlocProvider.of<PostBloc>(context).add(PerformLoadMoreComments(context: context));
              }, child: Row(
                children: <Widget>[
                  Icon(Icons.replay),
                  SizedBox(width: 8,),
                  Text('Load Previous Comments'),
                ],
              ),),
            ],
          );
  }
}

class CommentListTile extends StatefulWidget {
  const CommentListTile({
    Key key,
    @required this.comments,
  }) : super(key: key);
  final Comments comments;

  @override
  _CommentListTileState createState() => _CommentListTileState();
}

class _CommentListTileState extends State<CommentListTile> {
  TextEditingController _textEditingController;
  bool isReply;
  @override
  void initState() {
    _textEditingController = new TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ListTile(
          leading: new Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(widget.comments.userImage)))),
          title: Text(widget.comments.userName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                    DateFormat.yMMMd().add_jm().format(DateTime.parse(widget.comments.updatedAt)),
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                height: 8,
              ),
              Text(widget.comments.comment),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context)..add(PerformCommentLike(commentId: widget.comments.id));
                      },
                      icon: Icon(Icons.thumb_up),
                      color: widget.comments.like ? Colors.blue : Colors.black),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context)..add(PerformCommentDislike(
                        commentId: widget.comments.id,
                      ));
                    },
                    icon: Icon(Icons.thumb_down),
                    color: widget.comments.dislike ? Colors.red : Colors.black,
                  ),
                  FlatButton(
                    onPressed: () async{
                      if(await PrefConfig.getIsLogin()){
                      _textEditingController.text =
                            "@${widget.comments.userName}: ";
                        setState(() {
                          isReply = true;
                        });
                      }else{
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder:(context) => AlertDialog(
                            title: Text('Login'),
                            content: Text('You should be logged in before commenting.'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('Login'),
                                onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>
                                  LoginView()));
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Reply'),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
        isReply == true
              ? Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (String messageText) {
                        },
                        onSubmitted: commentSubmitted,
                        decoration:
                            InputDecoration.collapsed(hintText: "Reply"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          commentSubmitted(_textEditingController.text);
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
        widget.comments.replies.length != 0 ?
        //FlatButton(onPressed: (){}, child: Text("${comments.replies.length} replies"),):
        RepliesView(replies: widget.comments.replies, commentId: widget.comments.id,):
        Container(),
        SizedBox(height: 8,),
      ],
    );
  }
  void commentSubmitted(String text) {
    BlocProvider.of<PostBloc>(context)..add(PerformCommentReply(reply: text, commentId: widget.comments.id));
    _textEditingController.clear();
    setState(() {
      isReply = false;
    });
  }
}
