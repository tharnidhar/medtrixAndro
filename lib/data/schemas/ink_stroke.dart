import 'package:isar/isar.dart';

part 'ink_stroke.g.dart';

@collection
class InkStroke {
  Id id = Isar.autoIncrement;

  late String videoId;
  late int page;

  late List<double> x;
  late List<double> y;

  late int color;
  late double size;
}
