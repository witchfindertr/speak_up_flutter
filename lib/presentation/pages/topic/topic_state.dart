import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speak_up/domain/entities/sentence/sentence.dart';
import 'package:speak_up/presentation/utilities/enums/loading_status.dart';

part 'topic_state.freezed.dart';

@freezed
class TopicState with _$TopicState {
  const factory TopicState({
    @Default(LoadingStatus.initial) LoadingStatus loadingStatus,
    @Default([]) List<Sentence> sentences,
    @Default([]) List<bool> isExpandedTranslations,
  }) = _TopicState;
}
