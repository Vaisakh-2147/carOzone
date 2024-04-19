import 'package:car_o_zone/screens/hive/model/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class HiveFunction {
  final user = FirebaseAuth.instance.currentUser;
  static const String _boxName = 'comments';

  Future<void> addComment(Comment comment, String carId) async {
    final box = await Hive.openBox<Comment>(_boxName);
    await box.put(comment.id, comment..carId = carId);
  }

  Future<List<Comment>> getComments(String carId) async {
    final box = await Hive.openBox<Comment>(_boxName);
    final comments =
        box.values.where((comment) => comment.carId == carId).toList();
    return comments;
  }

  Future<void> deleteComment(String id) async {
    final box = await Hive.openBox<Comment>(_boxName);
    await box.delete(id);
  }

  Future<void> updateComment(String id, String newText) async {
    final box = await Hive.openBox<Comment>(_boxName);
    final comment = box.get(id);
    if (comment != null) {
      final updatedComment = comment..text = newText;
      await box.put(id, updatedComment);
    }
  }
}
