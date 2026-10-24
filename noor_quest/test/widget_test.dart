import 'package:flutter_test/flutter_test.dart';
import 'package:noor_quest/data/lessons/lesson_catalog.dart';

void main() {
  test('MVP catalog is non-empty', () {
    expect(LessonCatalog.arabicLetters, isNotEmpty);
    expect(LessonCatalog.wuduSteps, isNotEmpty);
    expect(LessonCatalog.mannersScenarios, isNotEmpty);
  });
}
