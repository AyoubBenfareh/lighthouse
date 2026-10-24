/// Structured educational content — separate from UI strings.
/// reviewStatus: draft | pending_educator_review | approved
class LessonMeta {
  const LessonMeta({
    required this.id,
    required this.topic,
    required this.ageMin,
    required this.ageMax,
    required this.learningObjective,
    required this.reviewStatus,
    required this.version,
    this.sourceReference,
  });

  final String id;
  final String topic;
  final int ageMin;
  final int ageMax;
  final String learningObjective;
  final String reviewStatus;
  final String version;
  final String? sourceReference;
}

class ArabicLetterItem {
  const ArabicLetterItem({
    required this.letter,
    required this.letterNameAr,
    required this.wordAr,
    required this.wordEn,
    required this.wordDe,
    required this.objectId,
  });

  final String letter;
  final String letterNameAr;
  final String wordAr;
  final String wordEn;
  final String wordDe;
  final String objectId;

  String wordFor(String locale) {
    switch (locale) {
      case 'ar':
        return wordAr;
      case 'de':
        return wordDe;
      default:
        return wordEn;
    }
  }
}

class WuduStep {
  const WuduStep({
    required this.id,
    required this.order,
    required this.titleEn,
    required this.titleAr,
    required this.titleDe,
    required this.noteEn,
    required this.iconId,
    this.jurisprudenceNote,
  });

  final String id;
  final int order;
  final String titleEn;
  final String titleAr;
  final String titleDe;
  final String noteEn;
  final String iconId;
  final String? jurisprudenceNote;

  String titleFor(String locale) {
    switch (locale) {
      case 'ar':
        return titleAr;
      case 'de':
        return titleDe;
      default:
        return titleEn;
    }
  }
}

class MannersScenario {
  const MannersScenario({
    required this.id,
    required this.situationEn,
    required this.situationAr,
    required this.situationDe,
    required this.choices,
    required this.correctIndex,
    required this.lessonEn,
    required this.lessonAr,
    required this.lessonDe,
    required this.sceneId,
  });

  final String id;
  final String situationEn;
  final String situationAr;
  final String situationDe;
  final List<MannersChoice> choices;
  final int correctIndex;
  final String lessonEn;
  final String lessonAr;
  final String lessonDe;
  final String sceneId;

  String situationFor(String locale) {
    switch (locale) {
      case 'ar':
        return situationAr;
      case 'de':
        return situationDe;
      default:
        return situationEn;
    }
  }

  String lessonFor(String locale) {
    switch (locale) {
      case 'ar':
        return lessonAr;
      case 'de':
        return lessonDe;
      default:
        return lessonEn;
    }
  }
}

class MannersChoice {
  const MannersChoice({
    required this.textEn,
    required this.textAr,
    required this.textDe,
  });

  final String textEn;
  final String textAr;
  final String textDe;

  String textFor(String locale) {
    switch (locale) {
      case 'ar':
        return textAr;
      case 'de':
        return textDe;
      default:
        return textEn;
    }
  }
}
