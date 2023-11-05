import 'package:hive/hive.dart';
part 'Links.g.dart';

@HiveType(typeId: 0)
class Links extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1, defaultValue: '0xdD3D3D3')
  late String color;
}
