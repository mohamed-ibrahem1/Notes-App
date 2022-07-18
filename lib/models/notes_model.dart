import 'package:hive_flutter/adapters.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  DateTime? creationDate;

  @HiveField(3)
  bool? done;

  Note({
    this.title,
    this.note,
    this.creationDate,
    this.done,
  });
}
