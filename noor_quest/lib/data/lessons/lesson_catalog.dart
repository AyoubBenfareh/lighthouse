import '../models/lesson_models.dart';

abstract final class LessonCatalog {
  static const arabicMeta = LessonMeta(
    id: 'arabic_letters_v1',
    topic: 'Arabic letter recognition',
    ageMin: 6,
    ageMax: 10,
    learningObjective:
        'Recognize initial Arabic letters and associate them with familiar objects.',
    reviewStatus: 'pending_educator_review',
    version: '1.0.0',
  );

  static const arabicLetters = <ArabicLetterItem>[
    ArabicLetterItem(
      letter: 'ا',
      letterNameAr: 'أَلِف',
      wordAr: 'أَسَد',
      wordEn: 'Lion',
      wordDe: 'Löwe',
      objectId: 'lion',
    ),
    ArabicLetterItem(
      letter: 'ب',
      letterNameAr: 'بَاء',
      wordAr: 'بَاب',
      wordEn: 'Door',
      wordDe: 'Tür',
      objectId: 'door',
    ),
    ArabicLetterItem(
      letter: 'ت',
      letterNameAr: 'تَاء',
      wordAr: 'تُفَّاح',
      wordEn: 'Apple',
      wordDe: 'Apfel',
      objectId: 'apple',
    ),
    ArabicLetterItem(
      letter: 'ث',
      letterNameAr: 'ثَاء',
      wordAr: 'ثَعْلَب',
      wordEn: 'Fox',
      wordDe: 'Fuchs',
      objectId: 'fox',
    ),
    ArabicLetterItem(
      letter: 'ج',
      letterNameAr: 'جِيم',
      wordAr: 'جَمَل',
      wordEn: 'Camel',
      wordDe: 'Kamel',
      objectId: 'camel',
    ),
    ArabicLetterItem(
      letter: 'ح',
      letterNameAr: 'حَاء',
      wordAr: 'حُوت',
      wordEn: 'Whale',
      wordDe: 'Wal',
      objectId: 'whale',
    ),
  ];

  static const wuduMeta = LessonMeta(
    id: 'wudu_sequence_v1',
    topic: 'Wudu introductory sequence',
    ageMin: 6,
    ageMax: 10,
    learningObjective:
        'Arrange a commonly taught introductory wudu sequence in order.',
    reviewStatus: 'pending_educator_review',
    version: '1.0.0',
    sourceReference:
        'Introductory teaching sequence — not a ruling; jurisprudential details vary.',
  );

  /// Commonly taught introductory sequence for children.
  /// Obligatory vs recommended acts and madhhab variations need educator review.
  static const wuduSteps = <WuduStep>[
    WuduStep(
      id: 'intention',
      order: 1,
      titleEn: 'Intention',
      titleAr: 'النِّيَّة',
      titleDe: 'Absicht',
      noteEn: 'Begin with a sincere intention in your heart.',
      iconId: 'heart',
      jurisprudenceNote: 'How intention is expressed differs by school.',
    ),
    WuduStep(
      id: 'wash_hands',
      order: 2,
      titleEn: 'Wash hands',
      titleAr: 'غَسْلُ اليَدَيْن',
      titleDe: 'Hände waschen',
      noteEn: 'Wash both hands carefully.',
      iconId: 'hands',
    ),
    WuduStep(
      id: 'mouth_nose',
      order: 3,
      titleEn: 'Mouth & nose',
      titleAr: 'المَضْمَضَة وَالاستِنشَاق',
      titleDe: 'Mund & Nase',
      noteEn: 'Rinse the mouth and clean the nose gently.',
      iconId: 'face',
      jurisprudenceNote: 'Details of rinsing may vary by school.',
    ),
    WuduStep(
      id: 'wash_face',
      order: 4,
      titleEn: 'Wash face',
      titleAr: 'غَسْلُ الوَجْهِ',
      titleDe: 'Gesicht waschen',
      noteEn: 'Wash the whole face with water.',
      iconId: 'face_wash',
    ),
    WuduStep(
      id: 'wash_arms',
      order: 5,
      titleEn: 'Wash arms',
      titleAr: 'غَسْلُ اليَدَيْن إلى المِرْفَقَيْن',
      titleDe: 'Arme waschen',
      noteEn: 'Wash arms up to the elbows.',
      iconId: 'arms',
    ),
    WuduStep(
      id: 'wipe_head',
      order: 6,
      titleEn: 'Wipe head',
      titleAr: 'مَسْحُ الرَّأس',
      titleDe: 'Kopf wischen',
      noteEn: 'Wipe the head with wet hands.',
      iconId: 'head',
      jurisprudenceNote: 'Extent of wiping differs by school.',
    ),
    WuduStep(
      id: 'wash_feet',
      order: 7,
      titleEn: 'Wash feet',
      titleAr: 'غَسْلُ القَدَمَيْن',
      titleDe: 'Füße waschen',
      noteEn: 'Wash both feet carefully.',
      iconId: 'feet',
    ),
  ];

  static const mannersMeta = LessonMeta(
    id: 'good_manners_v1',
    topic: 'Everyday Islamic manners (akhlaq)',
    ageMin: 6,
    ageMax: 10,
    learningObjective:
        'Choose kind, honest, respectful responses in everyday child scenarios.',
    reviewStatus: 'pending_educator_review',
    version: '1.0.0',
  );

  static const mannersScenarios = <MannersScenario>[
    MannersScenario(
      id: 'help_books',
      situationEn: 'A child dropped their books. What do you do?',
      situationAr: 'سقطت كتب طفل. ماذا تفعل؟',
      situationDe: 'Einem Kind sind die Bücher heruntergefallen. Was tust du?',
      choices: [
        MannersChoice(
          textEn: 'Help pick them up',
          textAr: 'أساعد في التقاطها',
          textDe: 'Helfen, sie aufzuheben',
        ),
        MannersChoice(
          textEn: 'Laugh and walk away',
          textAr: 'أضحك وأمضي',
          textDe: 'Lachen und weggehen',
        ),
        MannersChoice(
          textEn: 'Pretend not to see',
          textAr: 'أتظاهر أنني لم أرَ',
          textDe: 'Tun, als sähe man nichts',
        ),
      ],
      correctIndex: 0,
      lessonEn: 'Helping others is a beautiful manner.',
      lessonAr: 'مساعدة الآخرين خلق جميل.',
      lessonDe: 'Anderen zu helfen ist eine schöne Eigenschaft.',
      sceneId: 'books',
    ),
    MannersScenario(
      id: 'tell_truth',
      situationEn: 'You broke a cup by mistake. What do you do?',
      situationAr: 'كسرت كوبًا بالخطأ. ماذا تفعل؟',
      situationDe: 'Du hast versehentlich eine Tasse zerbrochen. Was tust du?',
      choices: [
        MannersChoice(
          textEn: 'Hide it quietly',
          textAr: 'أخفيها بهدوء',
          textDe: 'Leise verstecken',
        ),
        MannersChoice(
          textEn: 'Tell the truth and say sorry',
          textAr: 'أقول الحقيقة وأعتذر',
          textDe: 'Die Wahrheit sagen und sich entschuldigen',
        ),
        MannersChoice(
          textEn: 'Blame someone else',
          textAr: 'ألوم شخصًا آخر',
          textDe: 'Jemanden anderen beschuldigen',
        ),
      ],
      correctIndex: 1,
      lessonEn: 'Honesty builds trust.',
      lessonAr: 'الصدق يبني الثقة.',
      lessonDe: 'Ehrlichkeit schafft Vertrauen.',
      sceneId: 'cup',
    ),
    MannersScenario(
      id: 'respect_parents',
      situationEn: 'Your parent asks you to tidy up. What do you do?',
      situationAr: 'يطلب منك والدك ترتيب المكان. ماذا تفعل؟',
      situationDe: 'Ein Elternteil bittet dich aufzuräumen. Was tust du?',
      choices: [
        MannersChoice(
          textEn: 'Answer respectfully and help',
          textAr: 'أرد بأدب وأساعد',
          textDe: 'Höflich antworten und helfen',
        ),
        MannersChoice(
          textEn: 'Shout that you are busy',
          textAr: 'أصرخ أنني مشغول',
          textDe: 'Schreien, dass man beschäftigt ist',
        ),
        MannersChoice(
          textEn: 'Ignore them',
          textAr: 'أتجاهلهم',
          textDe: 'Ignorieren',
        ),
      ],
      correctIndex: 0,
      lessonEn: 'Speaking kindly to parents is a great manners.',
      lessonAr: 'الكلام بلطف مع الوالدين من حسن الخلق.',
      lessonDe: 'Freundlich zu den Eltern zu sprechen ist gute Manieren.',
      sceneId: 'parents',
    ),
    MannersScenario(
      id: 'sharing',
      situationEn: 'You have snacks and a friend has none. What do you do?',
      situationAr: 'معك وجبة خفيفة وصديقك بلا شيء. ماذا تفعل؟',
      situationDe: 'Du hast einen Snack, ein Freund nichts. Was tust du?',
      choices: [
        MannersChoice(
          textEn: 'Eat everything alone',
          textAr: 'آكل كل شيء وحدي',
          textDe: 'Alles allein essen',
        ),
        MannersChoice(
          textEn: 'Share with your friend',
          textAr: 'أشارك مع صديقي',
          textDe: 'Mit dem Freund teilen',
        ),
        MannersChoice(
          textEn: 'Hide the snacks',
          textAr: 'أخفي الوجبة',
          textDe: 'Den Snack verstecken',
        ),
      ],
      correctIndex: 1,
      lessonEn: 'Sharing brings joy to everyone.',
      lessonAr: 'المشاركة تدخل السرور على الجميع.',
      lessonDe: 'Teilen macht alle froh.',
      sceneId: 'share',
    ),
    MannersScenario(
      id: 'clean_space',
      situationEn: 'The play area is messy after games. What do you do?',
      situationAr: 'منطقة اللعب فوضوية بعد الألعاب. ماذا تفعل؟',
      situationDe: 'Der Spielbereich ist nach dem Spielen unordentlich. Was tust du?',
      choices: [
        MannersChoice(
          textEn: 'Leave it for others',
          textAr: 'أتركها للآخرين',
          textDe: 'Für andere liegen lassen',
        ),
        MannersChoice(
          textEn: 'Help clean up together',
          textAr: 'نساعد في التنظيف معًا',
          textDe: 'Gemeinsam aufräumen',
        ),
        MannersChoice(
          textEn: 'Make more mess',
          textAr: 'أزيد الفوضى',
          textDe: 'Noch mehr Unordnung machen',
        ),
      ],
      correctIndex: 1,
      lessonEn: 'Cleanliness is part of good manners.',
      lessonAr: 'النظافة من حسن الخلق.',
      lessonDe: 'Sauberkeit gehört zu guten Manieren.',
      sceneId: 'clean',
    ),
  ];

  static const badgeIds = <String>[
    'first_star',
    'letter_learner',
    'wudu_explorer',
    'kind_heart',
    'map_traveler',
    'star_collector',
  ];
}
