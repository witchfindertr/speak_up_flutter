import 'package:flutter/material.dart';
import 'package:speak_up/presentation/pages/common_words_types/common_word_types.dart';
import 'package:speak_up/presentation/pages/expression_types/expression_types_view.dart';
import 'package:speak_up/presentation/pages/idiom_types/idiom_types_view.dart';
import 'package:speak_up/presentation/pages/pattern_lesson_detail/pattern_lesson_detail_view.dart';
import 'package:speak_up/presentation/pages/phrasal_verb_types/phrasal_verb_types_view.dart';
import 'package:speak_up/presentation/pages/tenses/tenses_view.dart';

List<Widget> lessonWidgetList = [
  const SizedBox(),
  const PatternLessonDetailView(),
  const ExpressionTypesView(),
  const PhrasalVerbTypesView(),
  const IdiomTypesView(),
  const CommonWordTypes(),
  const TensesView()
];
