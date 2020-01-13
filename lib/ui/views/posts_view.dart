import 'package:flutter/material.dart';
import 'package:flutter_assign/core/blocs/postBloc/bloc.dart';
import 'package:flutter_assign/core/models/login_entity.dart';
import 'package:flutter_assign/ui/views/login_view.dart';
import 'package:flutter_assign/ui/widgets/comment_widget.dart';
import 'package:flutter_assign/utils/pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key key, @required this.login}) : super(key: key);
  final LoginEntity login;
  PostView(){
    checkLogin();
  }
  void checkLogin()async{
    if(login == null) await PrefConfig.setIsLogin(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(title: Text('Disqus System')),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child: login != null ? UserAccountsDrawerHeader(
                accountEmail: Text(login.emailId),
                accountName: Text(login.username),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(login.image),
                ),
              ): UserAccountsDrawerHeader(
                accountEmail: OutlineButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ));
                },
                child: Text('Login'),),
                accountName: Text('Not logged in'),
                
              ),
            ),
            ListTile(
              onTap: () async{
                await PrefConfig.setIsLogin(false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));

              },
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
            )
          ],
        ),
      ),
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 8,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Container(
            padding: EdgeInsets.all(16),
            child: BlocProvider(
              create: (context) => PostBloc()
                ..add(PerformPostRequest(context: context)),
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostStateError) {
                    return Center(
                      child: Text(state.errorMessaage),
                    );
                  } else if (state is PostStateLoaded) {
                    return PostListWidget(state: state);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )),
      ),
    );
  }
}

class PostListWidget extends StatefulWidget {
  const PostListWidget({Key key, @required this.state}) : super(key: key);
  final PostStateLoaded state;

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  TextEditingController _textEditingController;
  bool isComment = false;

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
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  child: ListTile(
                    leading: new Container(
                        width: 60.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    new NetworkImage(widget.state.obj.userImage)))),
                    title: Text(widget.state.obj.userName),
                    subtitle: Text(DateFormat.yMMMd().add_jm()
                        .format(DateTime.parse(widget.state.obj.updatedAt))),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.state.obj.description,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 200,
                  child: Image.network(widget.state.obj.image),
                ),
                SizedBox(
                  height: 8,
                ),
                //Text("${widget.state.obj.comments.length} comments"),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<PostBloc>(context)..add(PerformPostLike(postId: widget.state.obj.id));
                        },
                        icon: Icon(Icons.thumb_up),
                        color: widget.state.obj.like ? Colors.blue : Colors.black),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context)
                          ..add(PerformPostDislike(postId: widget.state.obj.id));
                      },
                      icon: Icon(Icons.thumb_down),
                      color: widget.state.obj.dislike ? Colors.red : Colors.black,
                    ),
                    FlatButton(
                      onPressed: () async{
                        if(await PrefConfig.getIsLogin()){
                        _textEditingController.text =
                            "@${widget.state.obj.userName}: ";
                        setState(() {
                          isComment = true;
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
                      child: Text('Comment'),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                CommentView(
                  comments: widget.state.obj.comments,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          isComment == true
              ? Row(
                  children: <Widget>[
                    Flexible(
                      child: new TextField(
                        controller: _textEditingController,
                        onChanged: (String messageText) {},
                        onSubmitted: commentSubmitted,
                        decoration:
                            new InputDecoration.collapsed(hintText: "Comment"),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: () {
                          commentSubmitted(_textEditingController.text);
                        },
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  void commentSubmitted(String text) {
    BlocProvider.of<PostBloc>(context)..add(PerformPostComment(comment: text));
    _textEditingController.clear();
    setState(() {
      isComment = false;
    });
  }
}
