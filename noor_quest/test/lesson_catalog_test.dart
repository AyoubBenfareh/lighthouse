import 'package:flutter_test/flutter_test.dart';
import 'package:noor_quest/data/lessons/lesson_catalog.dart';

void main() {
  test('arabic letter catalog has six initial letters', () {
    expect(LessonCatalog.arabicLetters, hasLength(6));
    expect(
      LessonCatalog.arabicLetters.map((e) => e.letter).toSet(),
      containsAll(['ا', 'ب', 'ت', 'ث', 'ج', 'ح']),
    );
  });

  test('wudu steps are uniquely ordered 1..n', () {
    final orders = LessonCatalog.wuduSteps.map((e) => e.order).toList()..sort();
    expect(orders, List.generate(orders.length, (i) => i + 1));
  });

  test('manners scenarios include five situations with correct indices', () {
    expect(LessonCatalog.mannersScenarios, hasLength(5));
    for (final s in LessonCatalog.mannersScenarios) {
      expect(s.choices.length, greaterThanOrEqualTo(2));
      expect(s.correctIndex, inInclusiveRange(0, s.choices.length - 1));
    }
  });

  test('lesson metas are marked for educator review', () {
    expect(LessonCatalog.arabicMeta.reviewStatus, 'pending_educator_review');
    expect(LessonCatalog.wuduMeta.reviewStatus, 'pending_educator_review');
    expect(LessonCatalog.mannersMeta.reviewStatus, 'pending_educator_review');
  });
}
