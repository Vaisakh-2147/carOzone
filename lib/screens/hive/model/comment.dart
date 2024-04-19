import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'comment.g.dart';

@HiveType(typeId: 0)
class Comment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String carId;

  @HiveField(2)
  String userId;

  @HiveField(3)
  String text;

  @HiveField(4)
  DateTime timestamp;

  Comment(
      {required this.id,
      required this.carId,
      required this.userId,
      required this.text,
      required this.timestamp});
}
