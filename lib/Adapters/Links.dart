import 'package:hive/hive.dart';
part 'Links.g.dart';

@HiveType(typeId: 0)
class Links extends HiveObject {
  @HiveField(0)
  List todos;

  @HiveField(1, defaultValue: false)
  bool? isProject;

  Links(
    this.todos,
    this.isProject,
  );
}
