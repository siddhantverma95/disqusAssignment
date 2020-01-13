import 'package:flutter/material.dart';
import 'package:flutter_assign/ui/views/posts_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Disqus System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostsView(
        login: null,
      ),
    );
  }
}