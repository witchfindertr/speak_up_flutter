import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speak_up/domain/entities/idiom/idiom.dart';
import 'package:speak_up/domain/entities/sentence/sentence.dart';
import 'package:speak_up/domain/use_cases/audio_player/play_audio_from_url_use_case.dart';
import 'package:speak_up/domain/use_cases/cloud_store/get_sentence_list_from_idiom_use_case.dart';
import 'package:speak_up/presentation/pages/idiom_learning/idiom_learning_state.dart';
import 'package:speak_up/presentation/utilities/constant/string.dart';
import 'package:speak_up/presentation/utilities/enums/loading_status.dart';

class IdiomLearningViewModel extends StateNotifier<IdiomLearningState> {
  final GetSentenceListFromIdiomUseCase _getSentenceListFromIdiomUseCase;
  final PlayAudioFromUrlUseCase _playAudioFromUrlUseCase;

  IdiomLearningViewModel(
    this._getSentenceListFromIdiomUseCase,
    this._playAudioFromUrlUseCase,
  ) : super(IdiomLearningState(
          idiom: Idiom.initial(),
        ));

  Future<void> fetchExampleSentences() async {
    state = state.copyWith(loadingStatus: LoadingStatus.inProgress);
    try {
      List<Sentence> sentences =
          await _getSentenceListFromIdiomUseCase.run(state.idiom.idiomID);
      state = state.copyWith(
        loadingStatus: LoadingStatus.success,
        exampleSentences: sentences,
      );
    } catch (e) {
      state = state.copyWith(loadingStatus: LoadingStatus.error);
    }
  }

  Future<void> setIdiom(Idiom idiom) async {
    state = state.copyWith(idiom: idiom);
  }

  Future<void> playAudio(String endpoint) async {
    String url = idiomAudioURL + endpoint + audioExtension;
    await _playAudioFromUrlUseCase.run(url);
  }

  Future<void> updateCurrentPage(int page) async {
    state = state.copyWith(currentPage: page);
  }

  Future<void> updateTotalPage() async {
    state = state.copyWith(totalPage: state.exampleSentences.length + 1);
  }
}