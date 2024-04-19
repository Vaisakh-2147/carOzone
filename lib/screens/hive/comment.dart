import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/hive/hive_function.dart';
import 'package:car_o_zone/screens/hive/model/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  final String carId;

  const CommentScreen({Key? key, required this.carId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController titleController = TextEditingController();
  late TextEditingController _textEditingController;
  late List<Comment> _comments = [];
  late User? _currentUser = null;
  late HiveFunction _hiveFunction;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _hiveFunction = HiveFunction();
    _getCurrentUser();
    _loadComments(widget.carId);
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    print(' current user is $_currentUser');
    setState(() {});
  }

  Future<void> _loadComments(String carId) async {
    try {
      _comments = await _hiveFunction.getComments(carId);
      setState(() {});
    } catch (e) {
      print('Failed to load comments: $e');
    }
  }

  Future<void> _addComment(String carId) async {
    if (_textEditingController.text.isNotEmpty) {
      try {
        _currentUser = FirebaseAuth.instance.currentUser;
        if (_currentUser != null) {
          Comment newComment = Comment(
            id: UniqueKey().toString(),
            userId: _currentUser!.uid,
            text: _textEditingController.text,
            timestamp: DateTime.now(),
            carId: carId,
          );
          await _hiveFunction.addComment(newComment, widget.carId);
          _textEditingController.clear();
          _loadComments(carId);
        } else {
          print('User is not authenticated.');
        }
      } catch (e) {
        print('Failed to add comment: $e');
      }
    }
  }

  Future<void> _deleteComment(String id) async {
    try {
      await _hiveFunction.deleteComment(id);
      _loadComments(widget.carId);
    } catch (e) {
      print('Failed to delete comment: $e');
    }
  }

  Future<void> _updateComment(String id, String newText) async {
    try {
      await _hiveFunction.updateComment(id, newText);
      _loadComments(widget.carId);
    } catch (e) {
      print('Failed to update comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        actions: _currentUser != null
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      _currentUser = null;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => _loadComments(widget.carId),
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                Comment comment = _comments[index];
                print('Comment text: ${comment.text}');
                String formattedDateTime =
                    DateFormat('yyyy-MM-dd HH:mm').format(comment.timestamp);
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 215, 207, 207),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: customBlueColor())),
                    child: const ClipRRect(),
                  ),
                  title: Text(comment.text),
                  subtitle: Text(formattedDateTime),
                  trailing: _currentUser != null
                      ? PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: const Text('Edit'),
                                onTap: () {
                                  editButtonClick(comment);
                                },
                              ),
                              PopupMenuItem(
                                child: const Text('Delete'),
                                onTap: () {
                                  _deleteComment(comment.id);
                                },
                              )
                            ];
                          })
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _currentUser != null
                      ? () => _addComment(widget.carId)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  editButtonClick(Comment comment) {
    titleController.text = comment.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Edit comments'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Title'),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      _updateComment(comment.id, titleController.text);
                    },
                    child: const Text('save'))
              ],
            ));
  }
}
